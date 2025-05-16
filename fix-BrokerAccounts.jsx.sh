#!/bin/bash

echo "⚙️ Vervang BrokerAccounts.jsx met volledige balanslogica"

cat > ./frontend/src/pages/BrokerAccounts.jsx << 'EOF'
import React, { useEffect, useState } from "react";

export default function BrokerAccounts() {
  const [accounts, setAccounts] = useState([
    {
      name: "Bybit Main",
      apiKey: "9TXkRo941oH1BKNgsv",
      apiSecret: "nk41ouxWX6PbBh5ifLv0vPQe6D5wAYekUDHQ",
      status: "Active",
      total: 0,
      available: 0
    }
  ]);

  useEffect(() => {
    async function fetchBalances() {
      const updated = await Promise.all(accounts.map(async (acc) => {
        try {
          const res = await fetch("/api/bybit/balance", {
            method: "POST",
            headers: { "Content-Type": "application/json" },
            body: JSON.stringify({
              apiKey: acc.apiKey,
              apiSecret: acc.apiSecret
            })
          });

          const json = await res.json();

          if (json.result?.list?.[0]) {
            const equity = parseFloat(json.result.list[0].totalEquity || 0);
            const available = parseFloat(json.result.list[0].totalAvailableBalance || 0);
            return { ...acc, total: equity, available: available };
          } else {
            console.error("❌ Ongeldige API-response:", json);
            return { ...acc, total: 0, available: 0, status: "Error" };
          }
        } catch (e) {
          console.error("❌ Fout bij ophalen balans:", e);
          return { ...acc, total: 0, available: 0, status: "Error" };
        }
      }));

      setAccounts(updated);
    }

    fetchBalances();
  }, []);

  return (
    <div className="p-6 text-white">
      <h1 className="text-2xl font-bold mb-4">Broker Accounts</h1>
      <table className="w-full text-left border border-gray-700">
        <thead className="bg-gray-800 text-gray-200">
          <tr>
            <th className="p-2">Naam</th>
            <th className="p-2">Status</th>
            <th className="p-2">Totaal</th>
            <th className="p-2">Beschikbaar</th>
          </tr>
        </thead>
        <tbody>
          {accounts.map((acc, i) => (
            <tr key={i} className="border-t border-gray-600">
              <td className="p-2">{acc.name}</td>
              <td className="p-2">{acc.status}</td>
              <td className="p-2">${acc.total.toFixed(2)}</td>
              <td className="p-2">${acc.available.toFixed(2)}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
EOF

echo "✅ BrokerAccounts.jsx is succesvol vervangen met balanslogica."
