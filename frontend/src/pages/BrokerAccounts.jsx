import React, { useEffect, useState } from 'react';

export default function BrokerAccounts() {
  const [accounts, setAccounts] = useState([]);
  const [showWizard, setShowWizard] = useState(false);
  const [selectedBrokers, setSelectedBrokers] = useState([]);
  const [accountInputs, setAccountInputs] = useState({});

  useEffect(() => {
    const stored = JSON.parse(localStorage.getItem('brokerAccounts') || '[]');
    setAccounts(stored);
    if (stored.length > 0) updateBalances(stored);
  }, []);

  const updateBalances = async (accList) => {
    const updated = await Promise.all(
      accList.map(async acc => {
        try {
          const res = await fetch('/api/bybit/balance', {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({ apiKey: acc.apiKey, apiSecret: acc.apiSecret })
          });
          const json = await res.json();
          const coinList = json?.results?.find(r => r.accountType === 'UNIFIED')?.balanceData?.list?.[0]?.coin || [];

          const balances = coinList.map(entry => ({
            coin: entry.coin,
            total: parseFloat(entry.walletBalance || 0),
            available: parseFloat(entry.availableToWithdraw || 0)
          }));

          return { ...acc, balances };
        } catch {
          return { ...acc, balances: [] };
        }
      })
    );
    setAccounts(updated);
    localStorage.setItem('brokerAccounts', JSON.stringify(updated));
  };

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
      type: broker.includes('Derivatives') ? 'Bybit Derivatives' : 'Bybit Spot',
      status: 'Active',
      balances: []
    }));
    const updatedAccounts = [...accounts, ...newAccounts];
    localStorage.setItem('brokerAccounts', JSON.stringify(updatedAccounts));
    setAccounts(updatedAccounts);
    setShowWizard(false);
    updateBalances(updatedAccounts);
  };

  const toggleStatus = (index) => {
    const updated = [...accounts];
    updated[index].status = updated[index].status === "Active" ? "Inactive" : "Active";
    setAccounts(updated);
    localStorage.setItem("brokerAccounts", JSON.stringify(updated));
  };

  const deleteAccount = (index) => {
    if (!window.confirm("Weet je zeker dat je dit account wilt verwijderen?")) return;
    const updated = accounts.filter((_, i) => i !== index);
    setAccounts(updated);
    localStorage.setItem("brokerAccounts", JSON.stringify(updated));
  };

  const editAccount = (index) => {
    const current = accounts[index];
    const newName = prompt("Nieuwe naam voor dit account:", current.name);
    if (!newName) return;
    const updated = [...accounts];
    updated[index].name = newName;
    setAccounts(updated);
    localStorage.setItem("brokerAccounts", JSON.stringify(updated));
  };

  const getTotalUSDT = (balances = []) =>
    balances.reduce((sum, b) => sum + (isNaN(b.total) ? 0 : b.total), 0).toFixed(2);

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
          <div className="text-right">
            <button
              onClick={() => setShowWizard(true)}
              className="bg-cyan-600 hover:bg-cyan-700 px-4 py-2 rounded"
            >
              Voeg account toe
            </button>
          </div>

          <div className="bg-gray-800 p-4 rounded shadow mt-4">
            <h2 className="text-xl font-semibold text-cyan-400 mb-4">Accounts</h2>
            <div className="overflow-x-auto">
              <table className="w-full text-sm text-left">
                <thead className="text-gray-300 border-b border-gray-600">
                  <tr>
                    <th className="py-2 px-3">Naam</th>
                    <th className="px-3">Type</th>
                    <th className="px-3">Status</th>
                    <th className="px-3">Saldo's</th>
                    <th className="px-3">Totaal (USDT)</th>
                    <th className="px-3">Acties</th>
                  </tr>
                </thead>
                <tbody>
                  {accounts.map((acc, i) => (
                    <tr key={i} className="text-gray-100 border-b border-gray-700 align-top">
                      <td className="py-2 px-3">{acc.name}</td>
                      <td className="px-3">{acc.type}</td>
                      <td className="px-3">{acc.status}</td>
                      <td className="px-3">
                        <ul className="space-y-1">
                          {acc.balances?.map((bal, j) => (
                            <li key={j}>
                              {bal.coin}: ${bal.total.toFixed(2)} ({bal.available.toFixed(2)} beschikbaar)
                            </li>
                          ))}
                        </ul>
                      </td>
                      <td className="px-3">${getTotalUSDT(acc.balances)}</td>
                      <td className="px-3 space-x-2">
                        <button onClick={() => editAccount(i)} className="px-2 py-1 bg-yellow-600 rounded">Wijzigen</button>
                        <button onClick={() => toggleStatus(i)} className="px-2 py-1 bg-blue-600 rounded">
                          {acc.status === "Active" ? "Deactiveren" : "Activeren"}
                        </button>
                        <button onClick={() => deleteAccount(i)} className="px-2 py-1 bg-red-600 rounded">Verwijderen</button>
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
