#!/bin/bash

echo "📁 Mappenstructuur aanmaken..."
mkdir -p src/pages
mkdir -p src/components
mkdir -p src/layout
mkdir -p src/config

echo "📚 Pagina's aanmaken..."
pages=("Dashboard" "Trades" "OpenTrades" "Signals" "Accounts" "TradingAI")
for page in "${pages[@]}"; do
  cat > "src/pages/$page.tsx" << EOF
import React from 'react';

export default function $page() {
  return (
    <div className="text-white p-6 text-xl font-bold">
      $page Pagina (WIP)
    </div>
  );
}
EOF
done

echo "📄 Configuratiebestand voor routes aanmaken..."
cat > src/config/routesConfig.ts << 'EOF'
export const routes = [
  { path: 'dashboard', title: 'Dashboard' },
  { path: 'trades', title: 'Trades' },
  { path: 'trades/open', title: 'Open Trades' },
  { path: 'signals', title: 'Signals' },
  { path: 'accounts', title: 'Accounts' },
  { path: 'trading/ai', title: 'AI Trading' },
];
EOF

echo "📦 Sidebar.tsx met dynamische links..."
cat > src/components/Sidebar.tsx << 'EOF'
import React from 'react';
import { NavLink } from 'react-router-dom';
import { routes } from '../config/routesConfig';

export default function Sidebar() {
  const linkClass = ({ isActive }: { isActive: boolean }) =>
    \`block px-4 py-2 rounded-lg text-white hover:bg-neon-cyan \${isActive ? 'bg-neon-cyan text-black font-bold' : ''}\`;

  return (
    <aside className="w-64 bg-dark-panel p-4 space-y-2">
      <h2 className="text-2xl font-bold mb-4 text-neon-cyan">Menu</h2>
      {routes.map(({ path, title }) => (
        <NavLink key={path} to={\`/\${path}\`} className={linkClass}>
          {title}
        </NavLink>
      ))}
    </aside>
  );
}
EOF

echo "🧠 App.tsx met dynamische routes..."
cat > src/App.tsx << 'EOF'
import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Layout from './layout/Layout';
import { routes } from './config/routesConfig';

import Dashboard from './pages/Dashboard';
import Trades from './pages/Trades';
import OpenTrades from './pages/OpenTrades';
import Signals from './pages/Signals';
import Accounts from './pages/Accounts';
import TradingAI from './pages/TradingAI';

const components: { [key: string]: React.ComponentType } = {
  Dashboard,
  Trades,
  OpenTrades,
  Signals,
  Accounts,
  TradingAI,
};

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Layout />}>
          {routes.map(({ path, title }) => {
            const key = title.replace(/\s/g, '');
            const Component = components[key];
            return <Route key={path} path={path} element={<Component />} />;
          })}
          <Route path="*" element={<div className="text-red-500 p-6 text-xl">404 - Pagina niet gevonden</div>} />
        </Route>
      </Routes>
    </Router>
  );
}
EOF

echo "🧩 Layout.tsx met Sidebar/Header/Footer..."
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

echo "✅ Dynamische router + menu ingesteld! Start met: npm run dev"
