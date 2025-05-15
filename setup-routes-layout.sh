#!/bin/bash

echo "📁 Mappenstructuur aanmaken..."
mkdir -p src/pages
mkdir -p src/components
mkdir -p src/layout

echo "🧠 App.tsx aanmaken..."
cat > src/App.tsx << 'EOF'
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Layout from './layout/Layout';
import Dashboard from './pages/Dashboard';
import Trades from './pages/Trades';
import Signals from './pages/Signals';
import Accounts from './pages/Accounts';

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Layout />}>
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="trades" element={<Trades />} />
          <Route path="signals" element={<Signals />} />
          <Route path="accounts" element={<Accounts />} />
        </Route>
      </Routes>
    </Router>
  );
}
EOF

echo "🎨 Layout.tsx aanmaken..."
cat > src/layout/Layout.tsx << 'EOF'
import React from 'react';
import { Outlet } from 'react-router-dom';
import Sidebar from '../components/Sidebar';
import Header from '../components/Header';
import Footer from '../components/Footer';

export default function Layout() {
  return (
    <div className="flex h-screen">
      <Sidebar />
      <div className="flex flex-col flex-1">
        <Header />
        <main className="p-6 overflow-auto flex-1 bg-dark-background">
          <Outlet />
        </main>
        <Footer />
      </div>
    </div>
  );
}
EOF

echo "📚 Sidebar.tsx aanmaken..."
cat > src/components/Sidebar.tsx << 'EOF'
import React from 'react';
import { NavLink } from 'react-router-dom';

export default function Sidebar() {
  const linkClass = ({ isActive }: { isActive: boolean }) =>
    \`block px-4 py-2 rounded-lg text-white hover:bg-neon-cyan \${isActive ? 'bg-neon-cyan text-black font-bold' : ''}\`;

  return (
    <aside className="w-64 bg-dark-panel p-4 space-y-2">
      <h2 className="text-2xl font-bold mb-4 text-neon-cyan">Menu</h2>
      <NavLink to="/dashboard" className={linkClass}>Dashboard</NavLink>
      <NavLink to="/trades" className={linkClass}>Trades</NavLink>
      <NavLink to="/signals" className={linkClass}>Signals</NavLink>
      <NavLink to="/accounts" className={linkClass}>Accounts</NavLink>
    </aside>
  );
}
EOF

echo "📌 Header.tsx aanmaken..."
cat > src/components/Header.tsx << 'EOF'
import React from 'react';

export default function Header() {
  return (
    <header className="bg-dark-header p-4 shadow-md">
      <h1 className="text-2xl font-bold text-neon-cyan">Crypto Analyse Dashboard</h1>
    </header>
  );
}
EOF

echo "📎 Footer.tsx aanmaken..."
cat > src/components/Footer.tsx << 'EOF'
import React from 'react';

export default function Footer() {
  return (
    <footer className="bg-dark-header p-4 text-sm text-gray-400 text-center">
      © 2025 CryptoAnalyse Pro
    </footer>
  );
}
EOF

echo "📄 Dummy pagina's aanmaken..."
for page in Dashboard Trades Signals Accounts; do
  cat > "src/pages/$page.tsx" << EOF
import React from 'react';

export default function $page() {
  return (
    <div className="text-white text-2xl font-bold">
      $page Pagina (WIP)
    </div>
  );
}
EOF
done

echo "✅ Alles klaar! Start je app met: npm run dev of yarn dev"
