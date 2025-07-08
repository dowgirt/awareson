const express = require('express');
const path = require('path');

const app = express();
const PORT = process.env.PORT || 8080;

// API endpoint example
app.get('/api/hello', (req, res) => {
  res.json({ message: 'Hello from backend!' });
});

// Serve frontend from build/
app.use(express.static(path.join(__dirname, 'client/build')));

app.get('*', (req, res) => {
  res.sendFile(path.join(__dirname, 'client/build', 'index.html'));
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
