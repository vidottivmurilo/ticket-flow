import pool from "./config/database";


export async function testDatabaseConnection() {
    try {
        const connection = await pool.getConnection();
        console.log('Database connection successful');
        connection.release();
    } catch (error) {
        console.error('Database connection failed:', error);
    } finally {
        pool.end();
    }
}

testDatabaseConnection();