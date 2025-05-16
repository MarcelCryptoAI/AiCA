#!/bin/bash

echo "⚙️ Setup voor AI Analyzer met drag & drop containers..."

FRONTEND_DIR="./frontend"
PAGES_DIR="$FRONTEND_DIR/src/pages"
COMPONENTS_DIR="$FRONTEND_DIR/src/components"
mkdir -p "$PAGES_DIR"
mkdir -p "$COMPONENTS_DIR"

# 1. Pagina TheAIAnalyzer.jsx
cat > "$PAGES_DIR/TheAIAnalyzer.jsx" <<'EOF'
import React, { useState } from 'react';
import DropContainer from '../components/DropContainer';
import IndicatorCard from '../components/IndicatorCard';

export default function TheAIAnalyzer() {
  const [signalSource, setSignalSource] = useState([]);
  const [activeIndicators, setActiveIndicators] = useState([]);
  const [inactiveIndicators, setInactiveIndicators] = useState([
    { id: 'RSI', name: 'RSI', winrate: 72, ibs: 65, manuallyDisabled: false },
    { id: 'EMA1', name: 'EMA (5)', winrate: 80, ibs: 85, manuallyDisabled: false },
    { id: 'EMA2', name: 'EMA (20)', winrate: 55, ibs: 60, manuallyDisabled: false },
    { id: 'WMA1', name: 'WMA (10)', winrate: 68, ibs: 50, manuallyDisabled: true },
    { id: 'VWMA1', name: 'VWMA (10)', winrate: 45, ibs: 30, manuallyDisabled: false }
  ]);

  return (
    <div className="p-4 text-white space-y-6">
      <h1 className="text-3xl font-bold">AI Crypto Analyzer</h1>

      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mt-8">
        <DropContainer
          title="🎯 Signaalbron"
          items={signalSource}
          setItems={setSignalSource}
          max={1}
        />
        <DropContainer
          title="✅ Actieve Bevestigers"
          items={activeIndicators}
          setItems={setActiveIndicators}
        />
        <DropContainer
          title="⛔ Inactief"
          items={inactiveIndicators}
          setItems={setInactiveIndicators}
          isInactive
        />
      </div>
    </div>
  );
}
EOF

# 2. Component DropContainer.jsx
cat > "$COMPONENTS_DIR/DropContainer.jsx" <<'EOF'
import React from 'react';
import IndicatorCard from './IndicatorCard';

export default function DropContainer({ title, items, setItems, max = Infinity, isInactive = false }) {
  return (
    <div className="bg-gray-800 p-4 rounded shadow min-h-[200px]">
      <h2 className="text-cyan-400 font-semibold mb-2">{title}</h2>
      <div className="space-y-2">
        {items.map((item) => (
          <IndicatorCard key={item.id} data={item} isInactive={isInactive} />
        ))}
        {items.length === 0 && <p className="text-gray-500 text-sm">Sleep hier indicatoren naartoe</p>}
      </div>
    </div>
  );
}
EOF

# 3. Component IndicatorCard.jsx
cat > "$COMPONENTS_DIR/IndicatorCard.jsx" <<'EOF'
import React from 'react';
import clsx from 'clsx';

export default function IndicatorCard({ data, isInactive }) {
  const tooLow = data.winrate < 70 || data.ibs < 70;
  const autoDisabled = tooLow && !data.manuallyDisabled;

  return (
    <div className={clsx(
      "p-3 rounded bg-gray-700 relative border border-cyan-700",
      autoDisabled && "opacity-40 pointer-events-none"
    )}>
      <div className="font-bold">{data.name}</div>
      <div className="text-xs text-gray-300">
        Winrate: {data.winrate}%, IBS: {data.ibs}%
      </div>
      {autoDisabled && (
        <div className="absolute top-0 left-0 w-full h-full bg-black bg-opacity-40 flex items-center justify-center text-xs text-red-400">
          Niet geldig (lage score)
        </div>
      )}
    </div>
  );
}
EOF

echo "✅ Pagina en componenten succesvol aangemaakt: frontend/src/pages/TheAIAnalyzer.jsx"
