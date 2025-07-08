import React, { useEffect, useState } from 'react';

function App() {
  const [message, setMessage] = useState('');
  const [messages, setMessages] = useState([]);
  const [loading, setLoading] = useState(true);

  const fetchMessages = async () => {
    setLoading(true);
    try {
      const res = await fetch('/api/messages');
      const data = await res.json();
      setMessages(data);
    } catch (err) {
      console.error('Error fetching messages:', err);
    } finally {
      setLoading(false);
    }
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
      console.error('Error submitting message:', error);
    }
  };

  const handleDelete = async (id) => {
    const confirmDelete = window.confirm('Are you sure you want to delete this message?');
    if (!confirmDelete) return;

    try {
      await fetch(`/api/messages/${id}`, {
        method: 'DELETE',
      });
      fetchMessages();
    } catch (err) {
      console.error('Error deleting message:', err);
    }
  };

  useEffect(() => {
    fetchMessages();
  }, []);

  return (
    <div style={{ padding: '2rem', fontFamily: 'Arial, sans-serif' }}>
      <h1>Send a message to display it</h1>

      <form onSubmit={handleSubmit} style={{ marginBottom: '1rem' }}>
        <input
          type="text"
          value={message}
          onChange={e => setMessage(e.target.value)}
          placeholder="Enter a message"
          style={{
            padding: '0.5rem',
            width: '300px',
            marginRight: '0.5rem',
            border: '1px solid #ccc',
            borderRadius: '4px',
          }}
        />
        <button
          type="submit"
          style={{
            padding: '0.5rem 1rem',
            backgroundColor: '#007bff',
            color: 'white',
            border: 'none',
            borderRadius: '4px',
          }}
        >
          Wyślij
        </button>
      </form>

      <div>
        <h2>Received messages:</h2>
        {loading ? (
          <p>Ładowanie...</p>
        ) : messages.length === 0 ? (
          <p>No messages available</p>
        ) : (
          <ul>
            {messages.map(msg => (
              <li key={msg.id} style={{ padding: '0.25rem 0' }}>
                {msg.text}
                <button
                  onClick={() => handleDelete(msg.id)}
                  style={{
                    marginLeft: '1rem',
                    backgroundColor: '#dc3545',
                    color: 'white',
                    border: 'none',
                    padding: '0.25rem 0.5rem',
                    borderRadius: '4px',
                    cursor: 'pointer',
                  }}
                >
                  Usuń
                </button>
              </li>
            ))}
          </ul>
        )}
      </div>
    </div>
  );
}

export default App;