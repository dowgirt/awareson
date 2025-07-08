const express = require('express');
const path = require('path');
const sql = require('mssql');

const app = express();
const PORT = process.env.PORT || 8080;

app.use(express.json());

// Konfiguracja bazy MSSQL
const dbConfig = {
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  server: process.env.DB_SERVER,
  database: process.env.DB_NAME,
  options: {
    encrypt: true, // Azure SQL
    trustServerCertificate: false,
  },
};

// Funkcja tworząca tabelę, jeśli nie istnieje
async function createTableIfNotExists() {
  try {
    const pool = await sql.connect(dbConfig);
    const tableCheck = await pool.request().query(`
      IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='messages' AND xtype='U')
      CREATE TABLE messages (
        id INT IDENTITY(1,1) PRIMARY KEY,
        text NVARCHAR(MAX) NOT NULL
      )
    `);
    console.log('Tabela messages jest gotowa');
  } catch (err) {
    console.error('Błąd przy tworzeniu tabeli:', err);
  }
}

// Uruchomienie tworzenia tabeli przy starcie
createTableIfNotExists();

app.get('/api/messages', async (req, res) => {
  try {
    await sql.connect(dbConfig);
    const result = await sql.query('SELECT * FROM messages ORDER BY id DESC');
    res.json(result.recordset);
  } catch (err) {
    console.error(err);
    res.status(500).send('DB error');
  }
});

app.post('/api/messages', async (req, res) => {
  const { text } = req.body;
  if (!text) return res.status(400).send('Missing text');

  try {
    await sql.connect(dbConfig);
    await sql.query`INSERT INTO messages (text) VALUES (${text})`;
    res.status(201).send('Message saved');
  } catch (err) {
    console.error(err);
    res.status(500).send('DB error');
  }
});

app.use(express.static(path.join(__dirname, 'client/build')));
app.get('*', (req, res) =>
  res.sendFile(path.join(__dirname, 'client/build', 'index.html'))
);

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
