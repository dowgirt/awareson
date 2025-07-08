import React, { useEffect, useState } from 'react';

function App() {
  const [data, setData] = useState([]);

  useEffect(() => {
    fetch('/api/data')
      .then(res => res.json())
      .then(setData)
      .catch(console.error);
  }, []);

  return (
    <div>
      <h1>Dane z MSSQL</h1>
      <ul>
        {data.map((row, idx) => (
          <li key={idx}>{JSON.stringify(row)}</li>
        ))}
      </ul>
    </div>
  );
}

export default App;
