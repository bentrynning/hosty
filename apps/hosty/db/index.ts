import { drizzle } from 'drizzle-orm/libsql';
import { createClient } from '@libsql/client';
import * as schema from './schema';

const client = createClient({
  url: process.env.DATABASE_URL || 'file:./local.db',
  authToken: process.env.DATABASE_AUTH_TOKEN,
});

// Enable WAL mode for better performance and concurrency
async function enableWalMode() {
  try {
    await client.execute('PRAGMA journal_mode = WAL;');
    await client.execute('PRAGMA synchronous = NORMAL;');
    await client.execute('PRAGMA cache_size = 1000000000;');
    await client.execute('PRAGMA foreign_keys = true;');
    await client.execute('PRAGMA temp_store = memory;');
    console.log('WAL mode enabled for SQLite database');
  } catch (error) {
    console.warn('Could not enable WAL mode:', error);
  }
}

// Initialize WAL mode
enableWalMode();

export const db = drizzle(client, { schema });
