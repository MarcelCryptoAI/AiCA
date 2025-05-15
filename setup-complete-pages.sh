#!/bin/bash

echo "🔧 STARTEN: Alle pagina's + layout herstellen..."

FRONTEND_DIR="./frontend"
PAGES_DIR="$FRONTEND_DIR/src/pages"
COMPONENTS_DIR="$FRONTEND_DIR/src/components"
APP_FILE="$FRONTEND_DIR/src/App.jsx"
SIDEBAR_FILE="$COMPONENTS_DIR/Sidebar.jsx"

mkdir -p "$PAGES_DIR"
mkdir -p "$COMPONENTS_DIR"

# 1. Pagina's aanmaken
if [ ! -f "$PAGES_DIR/Dashboard.jsx" ]; then
  echo "➕ Pagina Dashboard.jsx aangemaakt"
  cat > "$PAGES_DIR/Dashboard.jsx" <<EOF
export default function Dashboard() {
  return <div className="text-white text-2xl p-4">Dashboard Pagina</div>;
}
EOF
else
  echo "✅ Dashboard.jsx bestaat al"
fi

if [ ! -f "$PAGES_DIR/OpenTrades.jsx" ]; then
  echo "➕ Pagina OpenTrades.jsx aangemaakt"
  cat > "$PAGES_DIR/OpenTrades.jsx" <<EOF
export default function OpenTrades() {
  return <div className="text-white text-2xl p-4">OpenTrades Pagina</div>;
}
EOF
else
  echo "✅ OpenTrades.jsx bestaat al"
fi

if [ ! -f "$PAGES_DIR/Signals.jsx" ]; then
  echo "➕ Pagina Signals.jsx aangemaakt"
  cat > "$PAGES_DIR/Signals.jsx" <<EOF
export default function Signals() {
  return <div className="text-white text-2xl p-4">Signals Pagina</div>;
}
EOF
else
  echo "✅ Signals.jsx bestaat al"
fi

if [ ! -f "$PAGES_DIR/Settings.jsx" ]; then
  echo "➕ Pagina Settings.jsx aangemaakt"
  cat > "$PAGES_DIR/Settings.jsx" <<EOF
export default function Settings() {
  return <div className="text-white text-2xl p-4">Settings Pagina</div>;
}
EOF
else
  echo "✅ Settings.jsx bestaat al"
fi

if [ ! -f "$PAGES_DIR/TheAIAnalyzer.jsx" ]; then
  echo "➕ Pagina TheAIAnalyzer.jsx aangemaakt"
  cat > "$PAGES_DIR/TheAIAnalyzer.jsx" <<EOF
export default function TheAIAnalyzer() {
  return <div className="text-white text-2xl p-4">TheAIAnalyzer Pagina</div>;
}
EOF
else
  echo "✅ TheAIAnalyzer.jsx bestaat al"
fi


# 2. App.jsx aanmaken (of overslaan)
if [ ! -f "$APP_FILE" ]; then
  echo "🧱 App.jsx wordt aangemaakt..."
  cat > "$APP_FILE" <<EOF
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Dashboard from './pages/Dashboard';
import OpenTrades from './pages/OpenTrades';
import Signals from './pages/Signals';
import Settings from './pages/Settings';
import TheAIAnalyzer from './pages/TheAIAnalyzer';

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
            <Route path="/the-ai-analyzer" element={<TheAIAnalyzer />} />
          </Routes>
        </div>
      </div>
    </Router>
  );
}
EOF
else
  echo "✅ App.jsx bestaat al – handmatige routecheck aanbevolen"
fi

# 3. Sidebar.jsx aanmaken indien nodig
if [ ! -f "$SIDEBAR_FILE" ]; then
  echo "📦 Sidebar.jsx wordt aangemaakt..."
  cat > "$SIDEBAR_FILE" <<EOF
import { NavLink } from 'react-router-dom';

const navItems = [
  { path: '/', title: 'Dashboard' },
  { path: '/open-trades', title: 'Open Trades' },
  { path: '/signals', title: 'Signals' },
  { path: '/settings', title: 'Settings' },
  { path: '/the-ai-analyzer', title: 'The AI Analyzer' },
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

echo "🎉 Alle pagina's en layout zijn gecontroleerd of aangemaakt!"
