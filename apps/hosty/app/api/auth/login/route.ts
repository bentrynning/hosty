import { authenticateUser, createSession } from '@/lib/auth';
import { NextRequest, NextResponse } from 'next/server';

export async function POST(request: NextRequest) {
  try {
    const { emailOrUsername, password } = await request.json();

    if (!emailOrUsername || !password) {
      return NextResponse.json(
        { message: 'Email/username and password are required' },
        { status: 400 }
      );
    }

    const user = await authenticateUser(emailOrUsername, password);

    if (!user) {
      return NextResponse.json(
        { message: 'Invalid credentials' },
        { status: 401 }
      );
    }

    // Only allow admin users to login
    if (user.role !== 'admin') {
      return NextResponse.json(
        { message: 'Access denied. Admin privileges required.' },
        { status: 403 }
      );
    }

    const sessionId = await createSession(user.id);

    const response = NextResponse.json(
      { message: 'Login successful', user: { id: user.id, email: user.email, username: user.username, role: user.role } },
      { status: 200 }
    );

    // Set session cookie
    response.cookies.set('session', sessionId, {
      httpOnly: true,
      secure: process.env.NODE_ENV === 'production',
      sameSite: 'lax',
      maxAge: 60 * 60 * 24, // 24 hours
    });

    return response;
  } catch (error) {
    console.error('Login error:', error);
    return NextResponse.json(
      { message: 'Internal server error' },
      { status: 500 }
    );
  }
}
