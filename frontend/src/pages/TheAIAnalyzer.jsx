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
