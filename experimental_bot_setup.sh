#!/bin/bash

echo "🧪 Voeg Experimental Bot pagina toe aan het project..."

# Controleer of we in de juiste directory zijn
if [ ! -d "frontend" ] || [ ! -d "backend" ]; then
  echo "❌ Fout: Voer dit script uit vanuit de projectroot (waar frontend/ en backend/ mappen staan)"
  exit 1
fi

echo "✅ Projectstructuur gevonden, ga verder..."

# Stap 1: Maak backup van kritieke bestanden
echo "📋 Maak backup van huidige bestanden..."
cp frontend/src/components/Sidebar.jsx frontend/src/components/Sidebar.jsx.backup
cp frontend/src/App.jsx frontend/src/App.jsx.backup

echo "✅ Backups aangemaakt"

# Stap 2: Maak nieuwe ExperimentalBot pagina aan
echo "🔧 Maak ExperimentalBot.jsx pagina aan..."
cat > frontend/src/pages/ExperimentalBot.jsx << 'EOF'
import React from 'react';

export default function ExperimentalBot() {
  return (
    <div className="p-6 text-white space-y-6">
      <h1 className="text-3xl font-bold">Experimental Bot</h1>
      
      <div className="bg-gray-800 p-6 rounded shadow space-y-4">
        <h2 className="text-xl font-semibold text-cyan-400">🧪 Test Environment</h2>
        <p className="text-gray-300">
          Deze pagina is in ontwikkeling. Hier komt de experimentele bot functionaliteit.
        </p>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-6">
          <div className="bg-gray-700 p-4 rounded">
            <h3 className="text-lg font-semibold text-cyan-200 mb-2">Bot Status</h3>
            <p className="text-gray-400">Nog niet actief</p>
          </div>
          
          <div className="bg-gray-700 p-4 rounded">
            <h3 className="text-lg font-semibold text-cyan-200 mb-2">Test Data</h3>
            <p className="text-gray-400">Geen data beschikbaar</p>
          </div>
        </div>
        
        <div className="mt-6">
          <button className="bg-cyan-600 hover:bg-cyan-700 px-4 py-2 rounded mr-2">
            Start Test
          </button>
          <button className="bg-gray-600 hover:bg-gray-700 px-4 py-2 rounded">
            Configuratie
          </button>
        </div>
      </div>
    </div>
  );
}
EOF

echo "✅ ExperimentalBot.jsx aangemaakt"

# Stap 3: Update Sidebar met nieuwe TEST sectie
echo "🔧 Update Sidebar met TEST sectie..."
cat > frontend/src/components/Sidebar.jsx << 'EOF'
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
  { title: "TEST", type: "section" },
  { path: "/experimental-bot", title: "Experimental Bot", type: "link" },
];

export default function Sidebar() {
  const linkClass = ({ isActive }) =>
    `block px-4 py-2 rounded-md transition-all duration-300 hover:bg-cyan-700 hover:shadow-lg ${isActive ? 'bg-cyan-500 text-white font-bold shadow-inner' : 'text-white'}`;

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

echo "✅ Sidebar bijgewerkt met TEST sectie"

# Stap 4: Voeg route toe aan App.jsx
echo "🔧 Voeg route toe aan App.jsx..."

# Voeg import toe na Billing import
sed -i '' '/import Billing from/a\
import ExperimentalBot from '\''./pages/ExperimentalBot'\'';
' frontend/src/App.jsx

# Voeg route toe na billing route
sed -i '' '/Route path="\/billing"/a\
            <Route path="/experimental-bot" element={<ExperimentalBot />} />
' frontend/src/App.jsx

echo "✅ Route toegevoegd aan App.jsx"

# Stap 5: Verificatie
echo "🔍 Verificatie van wijzigingen..."

# Controleer of de bestanden bestaan
if [ -f "frontend/src/pages/ExperimentalBot.jsx" ]; then
  echo "✅ ExperimentalBot.jsx bestaat"
else
  echo "❌ ExperimentalBot.jsx niet gevonden"
fi

# Controleer of imports correct zijn toegevoegd
if grep -q "ExperimentalBot" frontend/src/App.jsx; then
  echo "✅ Import toegevoegd aan App.jsx"
else
  echo "❌ Import niet gevonden in App.jsx"
fi

# Controleer of route correct is toegevoegd
if grep -q "experimental-bot" frontend/src/App.jsx; then
  echo "✅ Route toegevoegd aan App.jsx"
else
  echo "❌ Route niet gevonden in App.jsx"
fi

echo ""
echo "🎉 Experimental Bot pagina succesvol toegevoegd!"
echo ""
echo "📝 Volgende stappen:"
echo "1. Start je frontend: cd frontend && npm run dev"
echo "2. Ga naar http://localhost:5173"
echo "3. Kijk in het menu onderaan bij 'TEST' → 'Experimental Bot'"
echo ""
echo "🔄 Als er problemen zijn, herstel dan met:"
echo "   cp frontend/src/components/Sidebar.jsx.backup frontend/src/components/Sidebar.jsx"
echo "   cp frontend/src/App.jsx.backup frontend/src/App.jsx"
echo ""
echo "✅ Bestaande functionaliteit zou intact moeten blijven:"
echo "   - Broker Accounts wizard"
echo "   - Closed Trades statistieken"  
echo "   - Balance updates"
echo "   - Alle andere pagina's"