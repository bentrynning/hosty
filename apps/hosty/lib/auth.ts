import bcrypt from 'bcryptjs';
import { eq } from 'drizzle-orm';
import { db } from '@/db';
import { users, type User, sessions } from '@/db/schema';

export async function hashPassword(password: string): Promise<string> {
  const saltRounds = 12;
  return bcrypt.hash(password, saltRounds);
}

export async function verifyPassword(password: string, hash: string): Promise<boolean> {
  return bcrypt.compare(password, hash);
}

export async function createUser(email: string, username: string, password: string, role: 'admin' | 'user' = 'user') {
  const passwordHash = await hashPassword(password);
  
  const [user] = await db.insert(users).values({
    email,
    username,
    passwordHash,
    role,
  }).returning();
  
  return user;
}

export async function authenticateUser(emailOrUsername: string, password: string): Promise<User | null> {
  const [user] = await db
    .select()
    .from(users)
    .where(eq(users.email, emailOrUsername))
    .union(
      db.select().from(users).where(eq(users.username, emailOrUsername))
    )
    .limit(1);

  if (!user || !user.isActive) {
    return null;
  }

  const isValidPassword = await verifyPassword(password, user.passwordHash);
  if (!isValidPassword) {
    return null;
  }

  return user;
}

export async function createSession(userId: number): Promise<string> {
  const sessionId = crypto.randomUUID();
  const expiresAt = new Date(Date.now() + 24 * 60 * 60 * 1000); // 24 hours

  await db.insert(sessions).values({
    id: sessionId,
    userId,
    expiresAt,
  });

  return sessionId;
}

export async function validateSession(sessionId: string): Promise<User | null> {
  const [session] = await db
    .select({
      user: users,
      session: sessions,
    })
    .from(sessions)
    .innerJoin(users, eq(sessions.userId, users.id))
    .where(eq(sessions.id, sessionId))
    .limit(1);

  if (!session || session.session.expiresAt < new Date()) {
    if (session) {
      await db.delete(sessions).where(eq(sessions.id, sessionId));
    }
    return null;
  }

  return session.user;
}

export async function deleteSession(sessionId: string): Promise<void> {
  await db.delete(sessions).where(eq(sessions.id, sessionId));
}
