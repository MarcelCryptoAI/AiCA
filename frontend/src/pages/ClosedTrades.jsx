import React, { useEffect, useState } from 'react';
import { fetchClosedTrades } from '../services/bybitService';

export default function ClosedTrades() {
  const [trades, setTrades] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const key = localStorage.getItem("bybitKey");
    const secret = localStorage.getItem("bybitSecret");
    if (key && secret) {
      fetchClosedTrades(key, secret).then(data => {
        setTrades(data.result?.list || []);
        setLoading(false);
      });
    }
  }, []);

  return (
    <div className="p-6 text-white space-y-4">
      <h1 className="text-3xl font-bold">Closed Trades</h1>
      {loading ? (
        <p>Laden...</p>
      ) : (
        <table className="w-full text-sm">
          <thead className="text-cyan-400 border-b border-gray-600">
            <tr>
              <th className="text-left">Symbol</th>
              <th>Side</th>
              <th>Qty</th>
              <th>Exec Price</th>
              <th>Time</th>
              <th>PNL</th>
            </tr>
          </thead>
          <tbody>
            {trades.map((t, i) => (
              <tr key={i} className="border-b border-gray-700">
                <td>{t.symbol}</td>
                <td>{t.side}</td>
                <td>{t.execQty}</td>
                <td>{t.execPrice}</td>
                <td>{new Date(t.execTime).toLocaleString()}</td>
                <td className={parseFloat(t.closedPnl) >= 0 ? "text-green-400" : "text-red-400"}>
                  {t.closedPnl || "-"}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  );
}
