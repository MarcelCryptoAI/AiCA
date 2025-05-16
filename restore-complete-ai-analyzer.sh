#!/bin/bash

echo "🔁 Herstellen van volledige TheAIAnalyzer.jsx met boven- en onderkant..."

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
  const [minWinrate, setMinWinrate] = useState(70);
  const [minIBS, setMinIBS] = useState(70);
  const [ibsWindow, setIBSWindow] = useState(25);
  const [minConfirmations, setMinConfirmations] = useState(5);
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

      {/* Filters */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
        <div>
          <label className="block mb-1">Min. Winrate %</label>
          <input type="number" value={minWinrate} onChange={e => setMinWinrate(+e.target.value)} className="w-full bg-gray-700 p-2 rounded text-white" />
        </div>
        <div>
          <label className="block mb-1">Min. IBS %</label>
          <input type="number" value={minIBS} onChange={e => setMinIBS(+e.target.value)} className="w-full bg-gray-700 p-2 rounded text-white" />
        </div>
        <div>
          <label className="block mb-1">IBS Window (laatste X trades)</label>
          <input type="number" value={ibsWindow} onChange={e => setIBSWindow(+e.target.value)} className="w-full bg-gray-700 p-2 rounded text-white" />
        </div>
        <div>
          <label className="block mb-1">Min. indicator bevestigingen</label>
          <input type="number" value={minConfirmations} onChange={e => setMinConfirmations(+e.target.value)} className="w-full bg-gray-700 p-2 rounded text-white" />
        </div>
      </div>

      {/* AI Advies */}
      <div className="bg-gray-800 rounded-lg p-4 mt-6 shadow-md">
        <h2 className="text-2xl text-cyan-400 font-bold mb-2">AI Advies</h2>
        <p className="text-lg"><strong>Advies:</strong> LONG (73%)</p>
        <p className="text-sm text-gray-300 mt-2">Gebaseerd op 14 van de 24 indicatoren boven drempelwaarde. Long-score: 650 vs. Short-score: 240. Totaal actief: 890.</p>
        <div className="mt-4 space-x-2">
          <button className="bg-cyan-600 hover:bg-cyan-700 px-4 py-2 rounded">Laag risico</button>
          <button className="bg-cyan-600 hover:bg-cyan-700 px-4 py-2 rounded">Middel risico</button>
          <button className="bg-cyan-600 hover:bg-cyan-700 px-4 py-2 rounded">Hoog risico</button>
        </div>
      </div>

      {/* AI Entryvoorstel */}
      <div className="bg-gray-800 rounded-lg p-4 mt-6 shadow-md">
        <h2 className="text-xl text-cyan-300 font-semibold mb-2">AI Entry, TP & SL voorstel</h2>
        <p className="text-gray-200">Op basis van weerstand- en supportzones en het totaaladvies berekent AI:</p>
        <ul className="list-disc pl-6 text-sm mt-2">
          <li><strong>Entry:</strong> 102.300 USDT</li>
          <li><strong>Take Profit:</strong> 104.900 USDT</li>
          <li><strong>Stop Loss:</strong> 101.200 USDT</li>
        </ul>
      </div>

      {/* Indicator containers */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mt-12">
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

# 2. Componenten opnieuw plaatsen (optioneel overschrijven)
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

echo "✅ Volledige herstel van TheAIAnalyzer.jsx met bovenste en onderste secties voltooid!"
