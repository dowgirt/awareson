import React, { useEffect, useState } from 'react';

function App() {
  const [message, setMessage] = useState('');
  const [messages, setMessages] = useState([]);

  const fetchMessages = () => {
    fetch('/api/messages')
      .then(res => res.json())
      .then(setMessages)
      .catch(console.error);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    if (!message.trim()) return;

    try {
      await fetch('/api/messages', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ text: message }),
      });
      setMessage('');
      fetchMessages();
    } catch (error) {
      console.error(error);
    }
  };

  useEffect(() => {
    fetchMessages();
  }, []);

  return (
    <div style={{ padding: '1rem' }}>
      <h1>Dane z MSSQL</h1>

      <form onSubmit={handleSubmit}>
        <input
          value={message}
          onChange={e => setMessage(e.target.value)}
          placeholder="Napisz wiadomość"
          style={{ width: '300px', marginRight: '0.5rem' }}
        />
        <button type="submit">Wyślij</button>
      </form>

      <ul>
        {messages.map(msg => (
          <li key={msg.id}>{msg.text}</li>
        ))}
      </ul>
    </div>
  );
}

export default App;
