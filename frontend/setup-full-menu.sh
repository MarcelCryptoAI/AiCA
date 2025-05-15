#!/bin/bash

echo "📁 Structuur opzetten..."
mkdir -p src/pages
mkdir -p src/components
mkdir -p src/layout
mkdir -p src/config

echo "📄 Pagina's aanmaken..."
pages=("OpenTrades" "ClosedTrades" "BrokerAccounts" "Assets" "TheAIAnalyzer" "SignalBots" "DCABots" "GridBots" "TradingviewBots" "LiveTraidingTerminal" "CopyTrade" "Forum" "SignalSubscriptions" "Watchlists" "Settings" "Upgrade" "Billing")
for page in "${pages[@]}"; do
  cat > "src/pages/$page.tsx" << EOF
import React from 'react';

export default function $page() {
  return (
    <div className='text-white p-6 text-xl font-bold'>
      $page Pagina (WIP)
    </div>
  );
}
EOF
done

echo "⚙️ routesConfig.ts instellen..."
cat > src/config/routesConfig.ts << 'EOF'
export const routes = [
  { title: 'My Portfolio', isHeader: true },
  { path: 'open-trades', title: 'Open Trades' },
  { path: 'closed-trades', title: 'Closed Trades' },
  { path: 'broker-accounts', title: 'Broker accounts' },
  { path: 'assets', title: 'Assets' },

  { title: 'Traiding', isHeader: true },
  { path: 'the-ai-analyzer', title: 'The AI Analyzer' },
  { path: 'signal-bots', title: 'Signal Bots' },
  { path: 'dca-bots', title: 'DCA Bots' },
  { path: 'grid-bots', title: 'Grid Bots' },
  { path: 'tradingview-bots', title: 'Tradingview Bots' },
  { path: 'live-traiding-terminal', title: 'Live Traiding Terminal' },
  { path: 'copy-trade', title: 'Copy Trade' },

  { title: 'Community', isHeader: true },
  { path: 'forum', title: 'Forum' },
  { path: 'signal-subscriptions', title: 'Signal Subscriptions' },
  { path: 'watchlists', title: 'Watchlists' },

  { title: 'My account', isHeader: true },
  { path: 'settings', title: 'Settings' },
  { path: 'upgrade', title: 'Upgrade' },
  { path: 'billing', title: 'Billing' }
];
EOF

echo "📦 Sidebar.tsx met dynamische links en titels..."
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
      {routes.map(({ path, title, isHeader }) =>
        isHeader ? (
          <div key={title} className="mt-4 mb-1 text-neon-purple uppercase text-xs tracking-wide">{title}</div>
        ) : (
          <NavLink key={path} to={\`/\${path}\`} className={linkClass}>
            {title}
          </NavLink>
        )
      )}
    </aside>
  );
}
EOF

echo "✅ Alles ingesteld! Run je app met: npm run dev"
