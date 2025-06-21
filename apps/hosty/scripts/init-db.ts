import { createUser } from '../lib/auth';

async function initializeDatabase() {
  try {
    console.log('Initializing database...');
    
    // Create the first admin user
    const adminEmail = 'admin@hosty.dev';
    const adminUsername = 'admin';
    const adminPassword = 'admin123'; // Change this in production!
    
    try {
      const admin = await createUser(adminEmail, adminUsername, adminPassword, 'admin');
      console.log('Admin user created:', { id: admin.id, email: admin.email, username: admin.username });
    } catch (error) {
      console.log('Admin user might already exist or another error occurred:', error);
    }
    
    console.log('Database initialization completed!');
    console.log('\nDefault admin credentials:');
    console.log('Email: admin@hosty.dev');
    console.log('Username: admin');
    console.log('Password: admin123');
    console.log('\n⚠️  Please change the default password after first login!');
    
  } catch (error) {
    console.error('Error initializing database:', error);
    process.exit(1);
  }
}

initializeDatabase();
