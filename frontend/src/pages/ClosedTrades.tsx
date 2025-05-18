import React, { useEffect, useState } from 'react';

export default function ClosedTrades() {
  const [trades, setTrades] = useState([]);
  const [loading, setLoading] = useState(true);
  const [stats, setStats] = useState({ winRate: 0, roi: 0, totalPnl: 0 });

  useEffect(() => {
    const loadTrades = async () => {
      setLoading(true);
      const accounts = JSON.parse(localStorage.getItem("brokerAccounts") || "[]");

      const allTrades = await Promise.all(
        accounts.map(async (acc) => {
          if (!acc.apiKey || !acc.apiSecret) return [];

          try {
            const res = await fetch('/api/bybit/closed-trades', {
              method: 'POST',
              headers: { 'Content-Type': 'application/json' },
              body: JSON.stringify({
                apiKey: acc.apiKey,
                apiSecret: acc.apiSecret
              })
            });

            const json = await res.json();
            const rawList = json?.result?.list || json?.trades || [];
            const parsedList = rawList.map((entry) =>
              typeof entry === "string" ? JSON.parse(entry) : entry
            );

            return parsedList.map(t => ({ ...t, accountName: acc.name }));
          } catch {
            return [];
          }
        })
      );

      const flatTrades = allTrades.flat();
      const totalPnl = flatTrades.reduce((sum, t) => sum + parseFloat(t.realizedPnl || "0"), 0);
      const totalCost = flatTrades.reduce((sum, t) => {
        const entry = parseFloat(t.entryPrice || "0");
        const qty = parseFloat(t.qty || "0");
        return sum + (entry * qty);
      }, 0);
      const roi = totalCost > 0 ? (totalPnl / totalCost) * 100 : 0;
      const wins = flatTrades.filter(t => parseFloat(t.realizedPnl || "0") > 0).length;
      const winRate = flatTrades.length > 0 ? (wins / flatTrades.length) * 100 : 0;

      setTrades(flatTrades);
      setStats({ totalPnl, roi, winRate });
      setLoading(false);
    };

    loadTrades();
  }, []);

  return (
    <div className="p-6 text-white">
      <h1 className="text-3xl font-bold mb-6">Closed Trades</h1>

      <div className="grid grid-cols-3 gap-4 mb-8">
        <div className="bg-gray-800 p-4 rounded shadow text-center">
          <div className="text-sm text-gray-400">Winst/Verlies Ratio</div>
          <div className="text-2xl font-bold">{stats.winRate.toFixed(1)}%</div>
        </div>
        <div className="bg-gray-800 p-4 rounded shadow text-center">
          <div className="text-sm text-gray-400">ROI</div>
          <div className={`text-2xl font-bold ${stats.roi >= 0 ? 'text-green-400' : 'text-red-400'}`}>
            {stats.roi >= 0 ? '+' : ''}{stats.roi.toFixed(2)}%
          </div>
        </div>
        <div className="bg-gray-800 p-4 rounded shadow text-center">
          <div className="text-sm text-gray-400">Totale P&L</div>
          <div className={`text-2xl font-bold ${stats.totalPnl >= 0 ? 'text-green-400' : 'text-red-400'}`}>
            {stats.totalPnl >= 0 ? '+' : ''}${stats.totalPnl.toFixed(2)}
          </div>
        </div>
      </div>

      <div className="overflow-x-auto bg-gray-900 rounded shadow">
        <table className="min-w-full text-sm">
          <thead className="bg-gray-800 text-gray-400 border-b border-gray-700 text-left">
            <tr>
              <th className="p-3">Account</th>
              <th>Symbol</th>
              <th>Side</th>
              <th>Qty</th>
              <th>Entry</th>
              <th>Exit</th>
              <th>PnL</th>
              <th>Profit %</th>
            </tr>
          </thead>
          <tbody>
            {trades.map((t, i) => {
              const entry = parseFloat(t.entryPrice || "0");
              const exit = parseFloat(t.exitPrice || "0");
              const qty = parseFloat(t.qty || "0");
              const pnl = parseFloat(t.realizedPnl || "0");
              const totalCost = entry * qty;
              const profitPct = totalCost > 0 ? (pnl / totalCost) * 100 : 0;
              const side = t.side === 'Buy' ? 'Long' : 'Short';
              const pnlColor = pnl >= 0 ? 'text-green-400' : 'text-red-400';

              return (
                <tr key={i} className="border-b border-gray-800 text-white">
                  <td className="p-3">{t.accountName}</td>
                  <td>{t.symbol}</td>
                  <td className={side === 'Long' ? 'text-green-300' : 'text-red-300'}>{side}</td>
                  <td>{qty > 0 ? qty : '-'}</td>
                  <td>{entry > 0 ? entry.toFixed(4) : '-'}</td>
                  <td>{exit > 0 ? exit.toFixed(4) : '-'}</td>
                  <td className={pnlColor}>{isNaN(pnl) ? '-' : `${pnl >= 0 ? '+' : ''}$${pnl.toFixed(2)}`}</td>
                  <td className={profitPct >= 0 ? 'text-green-400' : 'text-red-400'}>
                    {isNaN(profitPct) ? '-' : `${profitPct >= 0 ? '+' : ''}${profitPct.toFixed(2)}%`}
                  </td>
                </tr>
              );
            })}
          </tbody>
        </table>
        {loading && <div className="p-4 text-gray-400">Bezig met laden...</div>}
        {!loading && trades.length === 0 && <div className="p-4 text-gray-400">Geen trades gevonden.</div>}
      </div>
    </div>
  );
}