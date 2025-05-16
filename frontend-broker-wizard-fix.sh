#!/bin/bash

echo "🧠 Werk BrokerAccounts pagina bij met wizard + API velden + beheeracties..."

# BrokerAccounts.jsx vervangen
cat > ./frontend/src/pages/BrokerAccounts.jsx << 'EOF'
import React, { useState, useEffect } from 'react';

export default function BrokerAccounts() {
  const [accounts, setAccounts] = useState([]);
  const [showWizard, setShowWizard] = useState(false);
  const [selectedBrokers, setSelectedBrokers] = useState([]);
  const [accountInputs, setAccountInputs] = useState({});

  useEffect(() => {
    const stored = JSON.parse(localStorage.getItem('brokerAccounts') || '[]');
    setAccounts(stored);
    if (stored.length === 0) setShowWizard(true);
  }, []);

  const handleInputChange = (broker, field, value) => {
    setAccountInputs(prev => ({
      ...prev,
      [broker]: { ...prev[broker], [field]: value }
    }));
  };

  const handleBrokerSelect = (broker) => {
    setSelectedBrokers(prev =>
      prev.includes(broker) ? prev.filter(b => b !== broker) : [...prev, broker]
    );
  };

  const finishWizard = () => {
    const newAccounts = selectedBrokers.map(broker => ({
      name: accountInputs[broker]?.name || broker,
      apiKey: accountInputs[broker]?.key || '',
      apiSecret: accountInputs[broker]?.secret || '',
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

  const toggleStatus = (i) => {
    const updated = [...accounts];
    updated[i].status = updated[i].status === 'Active' ? 'Inactive' : 'Active';
    setAccounts(updated);
    localStorage.setItem('brokerAccounts', JSON.stringify(updated));
  };

  const deleteAccount = (i) => {
    const updated = [...accounts];
    updated.splice(i, 1);
    setAccounts(updated);
    localStorage.setItem('brokerAccounts', JSON.stringify(updated));
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
              <h2 className="text-xl font-semibold text-cyan-400 mt-6">Stap 2: Vul API gegevens en naam in</h2>
              {selectedBrokers.map(broker => (
                <div key={broker} className="space-y-2 mt-4">
                  <input
                    type="text"
                    placeholder={"Naam voor " + broker}
                    className="bg-gray-700 w-full p-2 rounded"
                    onChange={e => handleInputChange(broker, 'name', e.target.value)}
                  />
                  <input
                    type="text"
                    placeholder="API Key"
                    className="bg-gray-700 w-full p-2 rounded"
                    onChange={e => handleInputChange(broker, 'key', e.target.value)}
                  />
                  <input
                    type="text"
                    placeholder="Secret Key"
                    className="bg-gray-700 w-full p-2 rounded"
                    onChange={e => handleInputChange(broker, 'secret', e.target.value)}
                  />
                </div>
              ))}
              <button onClick={finishWizard} className="mt-4 bg-cyan-600 hover:bg-cyan-700 px-4 py-2 rounded">
                Gereed
              </button>
            </>
          )}
        </div>
      ) : (
        <div className="bg-gray-800 p-4 rounded shadow mt-4">
          <h2 className="text-xl font-semibold text-cyan-400 mb-4">Accounts</h2>
          <div className="overflow-x-auto">
            <table className="w-full text-sm">
              <thead className="text-gray-300 border-b border-gray-600">
                <tr>
                  <th className="text-left py-2">Name</th>
                  <th>Status</th>
                  <th>Total</th>
                  <th>Available</th>
                  <th>Acties</th>
                </tr>
              </thead>
              <tbody>
                {accounts.map((acc, i) => (
                  <tr key={i} className="text-gray-100 border-b border-gray-700">
                    <td className="py-2">{acc.name}</td>
                    <td><span className={\`text-\${acc.status === 'Active' ? 'green' : 'red'}-400\`}>{acc.status}</span></td>
                    <td>${acc.total.toFixed(2)}</td>
                    <td>${acc.available.toFixed(2)}</td>
                    <td className="space-x-2">
                      <button onClick={() => toggleStatus(i)} className="bg-gray-700 px-2 py-1 rounded text-xs">
                        {acc.status === 'Active' ? 'Deactiveer' : 'Activeer'}
                      </button>
                      <button onClick={() => deleteAccount(i)} className="bg-red-600 px-2 py-1 rounded text-xs">
                        Verwijder
                      </button>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      )}
    </div>
  );
}
EOF

echo "✅ Wizard, API inputs en beheerknoppen voor broker accounts zijn ingesteld!"
