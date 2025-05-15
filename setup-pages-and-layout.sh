#!/bin/bash

echo "🔧 STARTEN: Pagina's + layout herstellen in React project..."

# Basispaden
FRONTEND_DIR="./frontend"
PAGES_DIR="$FRONTEND_DIR/src/pages"
COMPONENTS_DIR="$FRONTEND_DIR/src/components"
APP_FILE="$FRONTEND_DIR/src/App.jsx"
SIDEBAR_FILE="$COMPONENTS_DIR/Sidebar.jsx"

# Stap 1: Pagina's aanmaken
mkdir -p "$PAGES_DIR"
PAGES=("Dashboard" "OpenTrades" "Signals" "Settings")

for PAGE in "${PAGES[@]}"; do
  FILE="$PAGES_DIR/${PAGE}.jsx"
  if [ ! -f "$FILE" ]; then
    echo "➕ Pagina $PAGE.jsx aangemaakt"
    cat > "$FILE" <<EOF
export default function $PAGE() {
  return <div className="text-white text-2xl p-4">$PAGE Pagina</div>;
}
EOF
  else
    echo "✅ $PAGE.jsx bestaat al"
  fi
done

# Stap 2: App.jsx aanmaken als hij niet bestaat
if [ ! -f "$APP_FILE" ]; then
  echo "🧱 App.jsx wordt aangemaakt..."
  cat > "$APP_FILE" <<EOF
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Dashboard from './pages/Dashboard';
import OpenTrades from './pages/OpenTrades';
import Signals from './pages/Signals';
import Settings from './pages/Settings';

export default function App() {
  return (
    <Router>
      <div className="flex">
        <Sidebar />
        <div className="flex-grow bg-gray-900 min-h-screen">
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/open-trades" element={<OpenTrades />} />
            <Route path="/signals" element={<Signals />} />
            <Route path="/settings" element={<Settings />} />
          </Routes>
        </div>
      </div>
    </Router>
  );
}
EOF
else
  echo "✅ App.jsx bestaat al"
fi

# Stap 3: Sidebar.jsx aanmaken indien nodig
mkdir -p "$COMPONENTS_DIR"
if [ ! -f "$SIDEBAR_FILE" ]; then
  echo "📦 Sidebar.jsx wordt aangemaakt..."
  cat > "$SIDEBAR_FILE" <<EOF
import { NavLink } from 'react-router-dom';

const navItems = [
  { path: '/', title: 'Dashboard' },
  { path: '/open-trades', title: 'Open Trades' },
  { path: '/signals', title: 'Signals' },
  { path: '/settings', title: 'Settings' },
];

export default function Sidebar() {
  const linkClass = ({ isActive }) =>
    \`block px-4 py-2 rounded-md transition-all duration-300 hover:bg-cyan-700 hover:shadow-lg \${isActive ? 'bg-cyan-500 text-white font-bold shadow-inner' : 'text-white'}\`;

  return (
    <div className="bg-gray-800 min-h-screen w-64 p-4 space-y-2">
      {navItems.map((item) => (
        <NavLink key={item.path} to={item.path} className={linkClass}>
          {item.title}
        </NavLink>
      ))}
    </div>
  );
}
EOF
else
  echo "✅ Sidebar.jsx bestaat al"
fi

echo "✅ Alle pagina's, router en layout zijn gecontroleerd of aangemaakt!"
