import React, { useEffect, useState } from 'react';
import { fetchOpenTrades } from '../services/bybitService';

export default function OpenTrades() {
  const [trades, setTrades] = useState([]);
  const [loading, setLoading] = useState(true);

  console.log("🚀 OpenTrades component geladen");

  useEffect(() => {
    console.log("⏳ Start fetch voor open trades");

    const key = localStorage.getItem("bybitKey");
    const secret = localStorage.getItem("bybitSecret");
    console.log("🔑 Stored API keys:", { key, secret });

    if (key && secret) {
      fetchOpenTrades(key, secret).then(data => {
        console.log("✅ Response open trades:", data);
        setTrades(data.result?.list || []);
        setLoading(false);
      }).catch(err => {
        console.error("❌ Fout bij ophalen open trades:", err);
        setLoading(false);
      });
    } else {
      console.warn("⚠️ Geen API-sleutels gevonden in localStorage");
      setLoading(false);
    }
  }, []);

  return (
    <div className="p-6 text-white space-y-4">
      <h1 className="text-3xl font-bold">Open Trades</h1>
      {loading ? (
        <p>Laden...</p>
      ) : (
        <table className="w-full text-sm">
          <thead className="text-cyan-400 border-b border-gray-600">
            <tr>
              <th className="text-left">Symbol</th>
              <th>Qty</th>
              <th>Side</th>
              <th>Entry Price</th>
              <th>Leverage</th>
              <th>Position Value</th>
              <th>PNL</th>
            </tr>
          </thead>
          <tbody>
            {trades.map((t, i) => (
              <tr key={i} className="border-b border-gray-700">
                <td>{t.symbol}</td>
                <td>{t.size}</td>
                <td>{t.side}</td>
                <td>{t.entryPrice}</td>
                <td>{t.leverage}</td>
                <td>{t.positionValue}</td>
                <td className={parseFloat(t.unrealisedPnl) >= 0 ? "text-green-400" : "text-red-400"}>
                  {t.unrealisedPnl}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}
