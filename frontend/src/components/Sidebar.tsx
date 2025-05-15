import React from 'react';
import { Link } from 'react-router-dom';

export default function Sidebar() {
  return (
    <div className="w-64 h-screen bg-gray-900 text-white p-4">
      <h2 className="text-xl font-bold mb-6">Welkom, &lt;naam&gt;</h2>
      <nav className="space-y-2">
        <Link to="/dashboard" className="block hover:bg-gray-800 p-2 rounded">Dashboard</Link>
        <div>
          <p className="font-semibold mt-4">Trades</p>
          <Link to="/trades/open" className="block hover:bg-gray-800 p-2 rounded">Open Trades</Link>
          <Link to="/trades/closed" className="block hover:bg-gray-800 p-2 rounded">Closed Trades</Link>
        </div>
        <div>
          <p className="font-semibold mt-4">PORTFOLIO</p>
          <Link to="/portfolio/accounts" className="block hover:bg-gray-800 p-2 rounded">Exchange accounts</Link>
          <Link to="/portfolio/assets" className="block hover:bg-gray-800 p-2 rounded">Assets</Link>
        </div>
        <div>
          <p className="font-semibold mt-4">TRADING</p>
          <Link to="/trading/ai" className="block hover:bg-gray-800 p-2 rounded">Ai Powered Trading</Link>
          <Link to="/trading/backtesting" className="block hover:bg-gray-800 p-2 rounded">Backtesting</Link>
          <Link to="/trading/signald" className="block hover:bg-gray-800 p-2 rounded">Signald</Link>
          <Link to="/trading/signalbots" className="block hover:bg-gray-800 p-2 rounded">Signal Bots</Link>
          <Link to="/trading/dca" className="block hover:bg-gray-800 p-2 rounded">DCA Bots</Link>
          <Link to="/trading/grid" className="block hover:bg-gray-800 p-2 rounded">GRID Bots</Link>
          <Link to="/trading/tradingview" className="block hover:bg-gray-800 p-2 rounded">Traidingview Bots</Link>
        </div>
        <div>
          <p className="font-semibold mt-4">SETTINGS</p>
          <Link to="/settings/general" className="block hover:bg-gray-800 p-2 rounded">General</Link>
          <Link to="/settings/api" className="block hover:bg-gray-800 p-2 rounded">API keys</Link>
          <Link to="/settings/subscription" className="block hover:bg-gray-800 p-2 rounded">Subscription</Link>
        </div>
      </nav>
    </div>
  );
}
