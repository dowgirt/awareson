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
    <div style={styles.container}>
      <header style={styles.header}>
        <h1 style={styles.title}>📨 Message Board</h1>
        <p style={styles.subtitle}>Send a message to display it from the MSSQL database</p>
      </header>

      <form onSubmit={handleSubmit} style={styles.form}>
        <input
          type="text"
          value={message}
          onChange={e => setMessage(e.target.value)}
          placeholder="Write your message..."
          style={styles.input}
        />
        <button type="submit" style={styles.button}>
          Send
        </button>
      </form>

      <section style={styles.messageSection}>
        <h2 style={styles.sectionTitle}>Received messages</h2>
        {loading ? (
          <p style={styles.info}>Loading...</p>
        ) : messages.length === 0 ? (
          <p style={styles.info}>No messages found</p>
        ) : (
          <ul style={styles.list}>
            {messages.map(msg => (
              <li key={msg.id} style={styles.messageItem}>
                <span>{msg.text}</span>
                <button
                  onClick={() => handleDelete(msg.id)}
                  style={styles.deleteButton}
                  title="Delete message"
                >
                  🗑️
                </button>
              </li>
            ))}
          </ul>
        )}
      </section>
    </div>
  );
}

const styles = {
  container: {
    maxWidth: '600px',
    margin: '0 auto',
    padding: '2rem',
    fontFamily: `'Segoe UI', Tahoma, Geneva, Verdana, sans-serif`,
    backgroundColor: '#f9f9f9',
    minHeight: '100vh',
  },
  header: {
    marginBottom: '2rem',
    textAlign: 'center',
  },
  title: {
    margin: 0,
    fontSize: '2rem',
    color: '#333',
  },
  subtitle: {
    color: '#555',
    marginTop: '0.5rem',
  },
  form: {
    display: 'flex',
    marginBottom: '2rem',
    gap: '0.5rem',
  },
  input: {
    flex: 1,
    padding: '0.75rem',
    fontSize: '1rem',
    border: '1px solid #ccc',
    borderRadius: '6px',
  },
  button: {
    padding: '0.75rem 1.5rem',
    backgroundColor: '#007bff',
    color: '#fff',
    border: 'none',
    borderRadius: '6px',
    cursor: 'pointer',
  },
  messageSection: {
    backgroundColor: '#fff',
    border: '1px solid #ddd',
    padding: '1rem',
    borderRadius: '6px',
  },
  sectionTitle: {
    fontSize: '1.25rem',
    marginBottom: '1rem',
    color: '#222',
  },
  list: {
    listStyle: 'none',
    paddingLeft: 0,
    margin: 0,
  },
  messageItem: {
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    padding: '0.5rem 0',
    borderBottom: '1px solid #eee',
  },
  deleteButton: {
    background: 'none',
    border: 'none',
    fontSize: '1rem',
    cursor: 'pointer',
    color: '#dc3545',
  },
  info: {
    color: '#777',
    fontStyle: 'italic',
  },
};

export default App;
