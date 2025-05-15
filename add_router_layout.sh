#!/bin/bash

echo "🔧 Voeg React Router + layout toe..."

cd frontend

# 1. Install React Router
npm install react-router-dom

# 2. Maak layout en pagina's
mkdir -p src/layout src/pages

# Layout component met Sidebar
cat > src/layout/Layout.tsx <<'EOL'
import React from 'react';
import Sidebar from '../components/Sidebar';
import { Outlet } from 'react-router-dom';

export default function Layout() {
  return (
    <div className="flex">
      <Sidebar />
      <main className="flex-1 p-6 bg-gray-100 min-h-screen">
        <Outlet />
      </main>
    </div>
  );
}
EOL

# Dashboard startpagina
cat > src/pages/Dashboard.tsx <<'EOL'
import React from 'react';

export default function Dashboard() {
  return (
    <div>
      <h1 className="text-2xl font-bold mb-4">Dashboard</h1>
      <p className="text-gray-700">Welkom op het dashboard. Hier komt straks alles samen.</p>
    </div>
  );
}
EOL

# App.tsx met routerstructuur
cat > src/App.tsx <<'EOL'
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Layout from './layout/Layout';
import Dashboard from './pages/Dashboard';

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route index element={<Dashboard />} />
        </Route>
      </Routes>
    </Router>
  );
}
EOL

# main.tsx aanpassen als entrypoint
cat > src/main.tsx <<'EOL'
import React from 'react';
import ReactDOM from 'react-dom/client';
import App from './App';
import './index.css';

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
);
EOL

echo "✅ Template met layout en dashboard route toegevoegd."
