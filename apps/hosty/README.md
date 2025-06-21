# Hosty - Web Application Platform

Hosty is a platform for deploying and managing web applications with a secure admin interface.

## Features

- **SQLite Database**: Using Drizzle ORM with @libsql/client
- **Admin Authentication**: Secure login system for admin users
- **Modern UI**: Built with Next.js 15 and Tailwind CSS
- **Database Management**: Drizzle Studio for database visualization
- **Bun Runtime**: Fast JavaScript runtime and package manager

## Setup

### Prerequisites

- [Bun](https://bun.sh/) installed on your system

### Installation

1. Install dependencies:
   ```bash
   bun install
   ```

2. Generate and push database schema:
   ```bash
   bun run db:generate
   bun run db:push
   ```

3. Initialize database with default admin user:
   ```bash
   bun run db:init
   ```

4. Start the development server:
   ```bash
   bun run dev
   ```

### Default Admin Credentials

After running `bun run db:init`, you can login with:

- **Email**: admin@hosty.dev
- **Username**: admin
- **Password**: admin123

⚠️ **Important**: Change the default password after first login!

## Database Management

### Available Scripts

- `bun run db:generate` - Generate migration files from schema
- `bun run db:push` - Push schema changes to database
- `bun run db:studio` - Open Drizzle Studio for database management
- `bun run db:init` - Initialize database with default admin user

### Drizzle Studio

Launch Drizzle Studio to manage your database:

```bash
bun run db:studio
```

This will open a web interface where you can:
- View and edit database records
- Explore table relationships
- Run custom queries

This project uses [`next/font`](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) to automatically optimize and load [Geist](https://vercel.com/font), a new font family for Vercel.

## Learn More

To learn more about Next.js, take a look at the following resources:

- [Next.js Documentation](https://nextjs.org/docs) - learn about Next.js features and API.
- [Learn Next.js](https://nextjs.org/learn) - an interactive Next.js tutorial.

You can check out [the Next.js GitHub repository](https://github.com/vercel/next.js) - your feedback and contributions are welcome!

## Deploy on Vercel

The easiest way to deploy your Next.js app is to use the [Vercel Platform](https://vercel.com/new?utm_medium=default-template&filter=next.js&utm_source=create-next-app&utm_campaign=create-next-app-readme) from the creators of Next.js.

Check out our [Next.js deployment documentation](https://nextjs.org/docs/app/building-your-application/deploying) for more details.
