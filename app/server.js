const express = require('express');
const sql = require('mssql');
const path = require('path');

const app = express();
const port = process.env.PORT || 3000;

// Middleware, aby backend mógł serwować statyczne pliki Reacta
app.use(express.static(path.join(__dirname, 'client/build')));

// Config MSSQL z env variables
const dbConfig = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER, // np. yourserver.database.windows.net
  database: process.env.DB_NAME,
  options: {
    encrypt: true, // konieczne dla Azure
  }
};

app.get('/api/data', async (req, res) => {
  try {
    await sql.connect(dbConfig);
    const result = await sql.query`SELECT TOP 5 * FROM your_table`;
    res.json(result.recordset);
  } catch (err) {
    console.error('DB error:', err);
    res.status(500).json({ error: 'Database error' });
  }
});

// Wszystkie inne requesty kierujemy do Reacta (frontend)
app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname + '/client/build/index.html'));
});

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
