#!/bin/bash

echo "🚀 Setup broker account wizard + dashboard layout..."

FRONTEND_DIR="./frontend"
PAGES_DIR="$FRONTEND_DIR/src/pages"
mkdir -p "$PAGES_DIR"

cat > "$PAGES_DIR/BrokerAccounts.jsx" <<'EOF'
import React, { useState, useEffect } from 'react';

export default function BrokerAccounts() {
  const [accounts, setAccounts] = useState([]);
  const [showWizard, setShowWizard] = useState(false);
  const [selectedBrokers, setSelectedBrokers] = useState([]);
  const [accountNames, setAccountNames] = useState({});

  useEffect(() => {
    const stored = JSON.parse(localStorage.getItem('brokerAccounts') || '[]');
    setAccounts(stored);
    if (stored.length === 0) setShowWizard(true);
  }, []);

  const handleBrokerSelect = (broker) => {
    setSelectedBrokers(prev =>
      prev.includes(broker)
        ? prev.filter(b => b !== broker)
        : [...prev, broker]
    );
  };

  const handleAccountNameChange = (broker, name) => {
    setAccountNames(prev => ({ ...prev, [broker]: name }));
  };

  const finishWizard = () => {
    const newAccounts = selectedBrokers.map(broker => ({
      name: accountNames[broker] || broker,
      broker,
      type: broker.includes('Derivatives') ? 'Derivatives' : 'Spot',
      status: 'Active',
      available: 0.04,
      total: 0.04
    }));
    localStorage.setItem('brokerAccounts', JSON.stringify(newAccounts));
    setAccounts(newAccounts);
    setShowWizard(false);
  };

  return (
    <div className="p-6 text-white space-y-6">
      <h1 className="text-3xl font-bold">Broker Accounts</h1>

      {showWizard ? (
        <div className="bg-gray-800 p-6 rounded shadow space-y-6">
          <h2 className="text-xl font-semibold text-cyan-400">Stap 1: Kies je broker(s)</h2>
          <div className="space-y-2">
            {['Bybit Spot', 'Bybit Derivatives'].map(broker => (
              <label key={broker} className="flex items-center space-x-2">
                <input
                  type="checkbox"
                  checked={selectedBrokers.includes(broker)}
                  onChange={() => handleBrokerSelect(broker)}
                />
                <span>{broker}</span>
              </label>
            ))}
          </div>

          {selectedBrokers.length > 0 && (
            <>
              <h2 className="text-xl font-semibold text-cyan-400 mt-6">Stap 2: Geef je account(s) een naam</h2>
              <div className="space-y-2">
                {selectedBrokers.map(broker => (
                  <input
                    key={broker}
                    type="text"
                    placeholder={"Naam voor " + broker}
                    value={accountNames[broker] || ''}
                    onChange={(e) => handleAccountNameChange(broker, e.target.value)}
                    className="bg-gray-700 w-full p-2 rounded"
                  />
                ))}
              </div>
              <button
                onClick={finishWizard}
                className="mt-4 bg-cyan-600 hover:bg-cyan-700 px-4 py-2 rounded"
              >
                Gereed
              </button>
            </>
          )}
        </div>
      ) : (
        <>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            {/* Donut (dummy) */}
            <div className="bg-gray-800 p-4 rounded shadow text-center">
              <div className="text-xl text-cyan-300 mb-2">Accounts allocation</div>
              <div className="text-3xl font-bold text-green-400">$0.08</div>
              <p className="text-xs text-gray-400 mt-1">Total</p>
              <ul className="text-sm mt-4 space-y-1">
                {accounts.map((a, i) => (
                  <li key={i} className="text-gray-300">• {a.name}</li>
                ))}
              </ul>
            </div>

            {/* Line chart placeholder */}
            <div className="bg-gray-800 p-4 rounded shadow">
              <div className="text-xl text-cyan-300 mb-2">Portfolio Change</div>
              <div className="text-sm text-red-400">-99.84%</div>
              <div className="text-gray-500 mt-6 text-xs">📉 Chart komt hier</div>
            </div>

            {/* Filters */}
            <div className="bg-gray-800 p-4 rounded shadow">
              <div className="text-xl text-cyan-300 mb-2">Filters</div>
              <div className="text-sm text-gray-400">Nog in ontwikkeling</div>
            </div>
          </div>

          {/* Accounts Table */}
          <div className="bg-gray-800 p-4 rounded shadow mt-8">
            <h2 className="text-xl font-semibold text-cyan-400 mb-4">Accounts</h2>
            <div className="overflow-x-auto">
              <table className="w-full text-sm">
                <thead className="text-gray-300 border-b border-gray-600">
                  <tr>
                    <th className="text-left py-2">Name</th>
                    <th>Status</th>
                    <th>Total</th>
                    <th>Available</th>
                  </tr>
                </thead>
                <tbody>
                  {accounts.map((acc, i) => (
                    <tr key={i} className="text-gray-100 border-b border-gray-700">
                      <td className="py-2">{acc.name}</td>
                      <td><span className="text-green-400">{acc.status}</span></td>
                      <td>${acc.total.toFixed(2)}</td>
                      <td>${acc.available.toFixed(2)}</td>
                    </tr>
                  ))}
                </tbody>
              </table>
            </div>
          </div>
        </>
      )}
    </div>
  );
}
EOF

echo "✅ BrokerAccounts.jsx is aangemaakt met wizard + layout!"
