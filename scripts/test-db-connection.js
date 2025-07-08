
const sql = require('mssql');
(async () => {
try {
    const config = {
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    server: process.env.DB_SERVER,
    database: process.env.DB_NAME,
    options: { encrypt: true }
    };
    const pool = await sql.connect(config);
    console.log('DB connection successful');
    await pool.close();
    process.exit(0);
} catch (err) {
    console.error('DB connection failed:', err);
    process.exit(1);
}
})();