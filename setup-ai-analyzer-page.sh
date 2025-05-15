#!/bin/bash

echo "🧠 Pagina TheAIAnalyzer.jsx wordt aangemaakt..."

FRONTEND_DIR="./frontend"
PAGES_DIR="$FRONTEND_DIR/src/pages"
mkdir -p "$PAGES_DIR"

cat > "$PAGES_DIR/TheAIAnalyzer.jsx" <<'EOF'
import React from 'react';

export default function TheAIAnalyzer() {
  return (
    <div className="p-4 text-white space-y-6">
      <h1 className="text-3xl font-bold">AI Crypto Analyzer</h1>

      {/* TradingView chart */}
      <div className="bg-gray-800 rounded-lg p-4 shadow-inner">
        <p className="text-cyan-400 font-semibold mb-2">Live Chart</p>
        <div className="bg-black h-64 flex items-center justify-center">[TRADINGVIEW CHART HIER]</div>
      </div>

      {/* Filters */}
      <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
        <div>
          <label className="block mb-1">Min. Winrate %</label>
          <input type="number" defaultValue={70} className="w-full bg-gray-700 p-2 rounded text-white" />
        </div>
        <div>
          <label className="block mb-1">Min. IBS %</label>
          <input type="number" defaultValue={70} className="w-full bg-gray-700 p-2 rounded text-white" />
        </div>
        <div>
          <label className="block mb-1">IBS Window (laatste X trades)</label>
          <input type="number" defaultValue={25} className="w-full bg-gray-700 p-2 rounded text-white" />
        </div>
        <div>
          <label className="block mb-1">Min. indicator bevestigingen</label>
          <input type="number" defaultValue={5} className="w-full bg-gray-700 p-2 rounded text-white" />
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

      {/* Indicator grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-4 mt-8">
        <div className="bg-gray-700 p-4 rounded shadow">
          <p className="text-sm text-gray-300">SMA(30)</p>
          <p className="text-lg text-white font-bold">103105.06</p>
          <p className="text-xs mt-1 text-red-400">Sell — IBS: 89%</p>
          <p className="text-xs mt-1 text-gray-400">Uitleg over deze indicator volgt...</p>
        </div>
      </div>
    </div>
  );
}

EOF

echo "✅ Pagina succesvol aangemaakt: frontend/src/pages/TheAIAnalyzer.jsx"
