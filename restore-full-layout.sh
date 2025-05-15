#!/bin/bash

echo "🔧 Volledige layout en sidebar worden hersteld..."

FRONTEND_DIR="./frontend"
PAGES_DIR="$FRONTEND_DIR/src/pages"
COMPONENTS_DIR="$FRONTEND_DIR/src/components"
APP_FILE="$FRONTEND_DIR/src/App.jsx"
SIDEBAR_FILE="$COMPONENTS_DIR/Sidebar.jsx"

mkdir -p "$PAGES_DIR"
mkdir -p "$COMPONENTS_DIR"

# Pagina's aanmaken
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
  return <div className="text-white text-2xl p-4">Open Trades Pagina</div>;
}
EOF
else
  echo "✅ OpenTrades.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/ClosedTrades.jsx" ]; then
  echo "➕ Pagina ClosedTrades.jsx aangemaakt"
  cat > "$PAGES_DIR/ClosedTrades.jsx" <<EOF
export default function ClosedTrades() {
  return <div className="text-white text-2xl p-4">Closed Trades Pagina</div>;
}
EOF
else
  echo "✅ ClosedTrades.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/BrokerAccounts.jsx" ]; then
  echo "➕ Pagina BrokerAccounts.jsx aangemaakt"
  cat > "$PAGES_DIR/BrokerAccounts.jsx" <<EOF
export default function BrokerAccounts() {
  return <div className="text-white text-2xl p-4">Broker Accounts Pagina</div>;
}
EOF
else
  echo "✅ BrokerAccounts.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/Assets.jsx" ]; then
  echo "➕ Pagina Assets.jsx aangemaakt"
  cat > "$PAGES_DIR/Assets.jsx" <<EOF
export default function Assets() {
  return <div className="text-white text-2xl p-4">Assets Pagina</div>;
}
EOF
else
  echo "✅ Assets.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/TheAIAnalyzer.jsx" ]; then
  echo "➕ Pagina TheAIAnalyzer.jsx aangemaakt"
  cat > "$PAGES_DIR/TheAIAnalyzer.jsx" <<EOF
export default function TheAIAnalyzer() {
  return <div className="text-white text-2xl p-4">The AI Analyzer Pagina</div>;
}
EOF
else
  echo "✅ TheAIAnalyzer.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/SignalBots.jsx" ]; then
  echo "➕ Pagina SignalBots.jsx aangemaakt"
  cat > "$PAGES_DIR/SignalBots.jsx" <<EOF
export default function SignalBots() {
  return <div className="text-white text-2xl p-4">Signal Bots Pagina</div>;
}
EOF
else
  echo "✅ SignalBots.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/DCABots.jsx" ]; then
  echo "➕ Pagina DCABots.jsx aangemaakt"
  cat > "$PAGES_DIR/DCABots.jsx" <<EOF
export default function DCABots() {
  return <div className="text-white text-2xl p-4">DCA Bots Pagina</div>;
}
EOF
else
  echo "✅ DCABots.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/GridBots.jsx" ]; then
  echo "➕ Pagina GridBots.jsx aangemaakt"
  cat > "$PAGES_DIR/GridBots.jsx" <<EOF
export default function GridBots() {
  return <div className="text-white text-2xl p-4">Grid Bots Pagina</div>;
}
EOF
else
  echo "✅ GridBots.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/TradingviewBots.jsx" ]; then
  echo "➕ Pagina TradingviewBots.jsx aangemaakt"
  cat > "$PAGES_DIR/TradingviewBots.jsx" <<EOF
export default function TradingviewBots() {
  return <div className="text-white text-2xl p-4">Tradingview Bots Pagina</div>;
}
EOF
else
  echo "✅ TradingviewBots.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/LiveTradingTerminal.jsx" ]; then
  echo "➕ Pagina LiveTradingTerminal.jsx aangemaakt"
  cat > "$PAGES_DIR/LiveTradingTerminal.jsx" <<EOF
export default function LiveTradingTerminal() {
  return <div className="text-white text-2xl p-4">Live Trading Terminal Pagina</div>;
}
EOF
else
  echo "✅ LiveTradingTerminal.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/CopyTrade.jsx" ]; then
  echo "➕ Pagina CopyTrade.jsx aangemaakt"
  cat > "$PAGES_DIR/CopyTrade.jsx" <<EOF
export default function CopyTrade() {
  return <div className="text-white text-2xl p-4">Copy Trade Pagina</div>;
}
EOF
else
  echo "✅ CopyTrade.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/Forum.jsx" ]; then
  echo "➕ Pagina Forum.jsx aangemaakt"
  cat > "$PAGES_DIR/Forum.jsx" <<EOF
export default function Forum() {
  return <div className="text-white text-2xl p-4">Forum Pagina</div>;
}
EOF
else
  echo "✅ Forum.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/SignalSubscriptions.jsx" ]; then
  echo "➕ Pagina SignalSubscriptions.jsx aangemaakt"
  cat > "$PAGES_DIR/SignalSubscriptions.jsx" <<EOF
export default function SignalSubscriptions() {
  return <div className="text-white text-2xl p-4">Signal Subscriptions Pagina</div>;
}
EOF
else
  echo "✅ SignalSubscriptions.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/Watchlists.jsx" ]; then
  echo "➕ Pagina Watchlists.jsx aangemaakt"
  cat > "$PAGES_DIR/Watchlists.jsx" <<EOF
export default function Watchlists() {
  return <div className="text-white text-2xl p-4">Watchlists Pagina</div>;
}
EOF
else
  echo "✅ Watchlists.jsx bestaat al"
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
if [ ! -f "$PAGES_DIR/Upgrade.jsx" ]; then
  echo "➕ Pagina Upgrade.jsx aangemaakt"
  cat > "$PAGES_DIR/Upgrade.jsx" <<EOF
export default function Upgrade() {
  return <div className="text-white text-2xl p-4">Upgrade Pagina</div>;
}
EOF
else
  echo "✅ Upgrade.jsx bestaat al"
fi
if [ ! -f "$PAGES_DIR/Billing.jsx" ]; then
  echo "➕ Pagina Billing.jsx aangemaakt"
  cat > "$PAGES_DIR/Billing.jsx" <<EOF
export default function Billing() {
  return <div className="text-white text-2xl p-4">Billing Pagina</div>;
}
EOF
else
  echo "✅ Billing.jsx bestaat al"
fi


# App.jsx aanmaken
cat > "$APP_FILE" <<EOF
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Dashboard from './pages/Dashboard';
import OpenTrades from './pages/OpenTrades';
import ClosedTrades from './pages/ClosedTrades';
import BrokerAccounts from './pages/BrokerAccounts';
import Assets from './pages/Assets';
import TheAIAnalyzer from './pages/TheAIAnalyzer';
import SignalBots from './pages/SignalBots';
import DCABots from './pages/DCABots';
import GridBots from './pages/GridBots';
import TradingviewBots from './pages/TradingviewBots';
import LiveTradingTerminal from './pages/LiveTradingTerminal';
import CopyTrade from './pages/CopyTrade';
import Forum from './pages/Forum';
import SignalSubscriptions from './pages/SignalSubscriptions';
import Watchlists from './pages/Watchlists';
import Settings from './pages/Settings';
import Upgrade from './pages/Upgrade';
import Billing from './pages/Billing';

export default function App() {
  return (
    <Router>
      <div className="flex">
        <Sidebar />
        <div className="flex-grow bg-gray-900 min-h-screen p-4">
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/open-trades" element={<OpenTrades />} />
            <Route path="/closed-trades" element={<ClosedTrades />} />
            <Route path="/broker-accounts" element={<BrokerAccounts />} />
            <Route path="/assets" element={<Assets />} />
            <Route path="/the-ai-analyzer" element={<TheAIAnalyzer />} />
            <Route path="/signal-bots" element={<SignalBots />} />
            <Route path="/dca-bots" element={<DCABots />} />
            <Route path="/grid-bots" element={<GridBots />} />
            <Route path="/tradingview-bots" element={<TradingviewBots />} />
            <Route path="/live-trading-terminal" element={<LiveTradingTerminal />} />
            <Route path="/copy-trade" element={<CopyTrade />} />
            <Route path="/forum" element={<Forum />} />
            <Route path="/signal-subscriptions" element={<SignalSubscriptions />} />
            <Route path="/watchlists" element={<Watchlists />} />
            <Route path="/settings" element={<Settings />} />
            <Route path="/upgrade" element={<Upgrade />} />
            <Route path="/billing" element={<Billing />} />
          </Routes>
        </div>
      </div>
    </Router>
  );
}
EOF

# Sidebar.jsx aanmaken
cat > "$SIDEBAR_FILE" <<EOF
import { NavLink } from 'react-router-dom';

const navItems = [
  { path: "/", title: "Dashboard", type: "link" },
  { path: "/open-trades", title: "Open Trades", type: "link" },
  { path: "/closed-trades", title: "Closed Trades", type: "link" },
  { title: "MY PORTFOLIO", type: "section" },
  { path: "/broker-accounts", title: "Broker Accounts", type: "link" },
  { path: "/assets", title: "Assets", type: "link" },
  { title: "TRADING", type: "section" },
  { path: "/the-ai-analyzer", title: "The AI Analyzer", type: "link" },
  { path: "/signal-bots", title: "Signal Bots", type: "link" },
  { path: "/dca-bots", title: "DCA Bots", type: "link" },
  { path: "/grid-bots", title: "Grid Bots", type: "link" },
  { path: "/tradingview-bots", title: "Tradingview Bots", type: "link" },
  { path: "/live-trading-terminal", title: "Live Trading Terminal", type: "link" },
  { path: "/copy-trade", title: "Copy Trade", type: "link" },
  { title: "COMMUNITY", type: "section" },
  { path: "/forum", title: "Forum", type: "link" },
  { path: "/signal-subscriptions", title: "Signal Subscriptions", type: "link" },
  { path: "/watchlists", title: "Watchlists", type: "link" },
  { title: "MY ACCOUNT", type: "section" },
  { path: "/settings", title: "Settings", type: "link" },
  { path: "/upgrade", title: "Upgrade", type: "link" },
  { path: "/billing", title: "Billing", type: "link" },
];

export default function Sidebar() {
  const linkClass = ({ isActive }) =>
    \`block px-4 py-2 rounded-md transition-all duration-300 hover:bg-cyan-700 hover:shadow-lg \${isActive ? 'bg-cyan-500 text-white font-bold shadow-inner' : 'text-white'}\`;

  return (
    <div className="bg-gray-800 min-h-screen w-64 p-4 space-y-2 text-white">
      <h2 className="text-lg font-bold mb-4">Menu</h2>
      {navItems.map((item, i) =>
        item.type === 'section' ? (
          <div key={i} className="mt-4 mb-1 text-cyan-400 text-xs font-bold uppercase">{item.title}</div>
        ) : (
          <NavLink key={item.path} to={item.path} className={linkClass}>
            {item.title}
          </NavLink>
        )
      )}
    </div>
  );
}
EOF

echo "✅ Alle componenten zijn succesvol aangemaakt en gekoppeld!"
