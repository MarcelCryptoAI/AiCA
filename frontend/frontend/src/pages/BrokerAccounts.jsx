import React, { useState, useEffect } from 'react';
import { Line } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  LineElement,
  PointElement,
  LinearScale,
  TimeScale,
  Tooltip,
  Legend
} from 'chart.js';
import 'chartjs-adapter-date-fns';

ChartJS.register(LineElement, PointElement, LinearScale, TimeScale, Tooltip, Legend);

export default function BrokerAccounts() {
  const [accounts, setAccounts] = useState([]);
  const [showWizard, setShowWizard] = useState(false);
  const [selectedBrokers, setSelectedBrokers] = useState([]);
  const [accountInputs, setAccountInputs] = useState({});
  const [selectedTimeframe, setSelectedTimeframe] = useState('1d');
  const [chartData, setChartData] = useState([]);

  useEffect(() => {
    const stored = JSON.parse(localStorage.getItem('brokerAccounts') || '[]');
    setAccounts(stored);
    if (stored.length === 0) setShowWizard(true);
    else generateFakeChart(stored);
  }, []);

  const timeframes = ['1h', '4h', '12h', '1d', '3d', '1w', 'All'];

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
    generateFakeChart(newAccounts);
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

  const generateFakeChart = (accounts) => {
    const now = Date.now();
    const interval = {
      '1h': 5 * 60 * 1000,
      '4h': 15 * 60 * 1000,
      '12h': 30 * 60 * 1000,
      '1d': 60 * 60 * 1000,
      '3d': 2 * 60 * 60 * 1000,
      '1w': 4 * 60 * 60 * 1000,
      'All': 6 * 60 * 60 * 1000,
    }[selectedTimeframe];

    const points = {
      '1h': 12,
      '4h': 16,
      '12h': 24,
      '1d': 36,
      '3d': 30,
      '1w': 28,
      'All': 50
    }[selectedTimeframe];

    const datasets = accounts.map((acc, i) => ({
      label: acc.name,
      data: Array(points).fill(0).map((_, j) => ({
        x: now - (points - j) * interval,
        y: Math.max(0.01, acc.total * (0.5 + Math.random()))
      })),
      borderColor: `hsl(${i * 60}, 80%, 60%)`,
      backgroundColor: 'transparent',
      tension: 0.3
    }));

    setChartData({ datasets });
  };

  useEffect(() => {
    if (accounts.length > 0) generateFakeChart(accounts);
  }, [selectedTimeframe]);

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
        <>
          {/* Tijdframe tabs */}
          <div className="flex space-x-3 border-b border-gray-700 pb-2 mb-2">
            {timeframes.map(tf => (
              <button
                key={tf}
                onClick={() => setSelectedTimeframe(tf)}
                className={\`px-3 py-1 rounded text-sm \${selectedTimeframe === tf ? 'bg-cyan-600' : 'bg-gray-700'}`}
              >
                {tf}
              </button>
            ))}
          </div>

          <div className="bg-gray-800 rounded p-4 shadow">
            <h2 className="text-xl font-semibold text-cyan-400 mb-2">Portfolio Change</h2>
            <Line data={chartData} options={{ responsive: true, plugins: { legend: { labels: { color: 'white' } } }, scales: { x: { type: 'time', ticks: { color: 'white' } }, y: { ticks: { color: 'white' } } } }} />
          </div>

          {/* Tabel */}
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
        </>
      )}
    </div>
  );
}
