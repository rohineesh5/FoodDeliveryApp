import { useEffect, useState } from 'react';

const API_URL = 'http://localhost:8080/api/health';

function App() {
  const [health, setHealth] = useState({ state: 'checking', message: 'Connecting to the kitchen...' });

  useEffect(() => {
    fetch(API_URL)
      .then((response) => {
        if (!response.ok) {
          throw new Error('The API returned an error.');
        }
        return response.json();
      })
      .then((data) => setHealth({ state: 'online', message: data.message }))
      .catch(() => setHealth({ state: 'offline', message: 'Start the Spring Boot backend to connect.' }));
  }, []);

  return (
    <main className="page-shell">
      <nav className="topbar">
        <a className="brand" href="/">foodly<span>.</span></a>
        <div className="role-switcher" aria-label="User role preview">
          <button className="role active" type="button">Customer</button>
          <button className="role" type="button">Admin</button>
        </div>
      </nav>

      <section className="hero">
        <div className="hero-copy">
          <p className="eyebrow">Freshly planned. Simply delivered.</p>
          <h1>Your next favorite meal is closer than you think.</h1>
          <p className="intro">A friendly foundation for discovering local food, ordering with ease, and bringing a little more joy to dinner.</p>
          <button className="primary-action" type="button">Explore the menu <span aria-hidden="true">-&gt;</span></button>
        </div>
        <div className="hero-art" aria-hidden="true">
          <div className="sun"></div>
          <div className="plate"><span>FOOD</span></div>
          <div className="leaf leaf-one"></div>
          <div className="leaf leaf-two"></div>
        </div>
      </section>

      <section className="status-strip">
        <span className={`status-dot ${health.state}`}></span>
        <span><strong>API status:</strong> {health.message}</span>
        <span className="status-endpoint">GET /api/health</span>
      </section>
    </main>
  );
}

export default App;
