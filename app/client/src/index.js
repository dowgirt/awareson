import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';

const App = () => (
  <div style={{ fontFamily: 'sans-serif', padding: '2rem' }}>
    <h1>Hello from React frontend!</h1>
    <p>This is rendered by React.</p>
  </div>
);

const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(<App />);
