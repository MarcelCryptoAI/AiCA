import React, { useEffect, useState } from 'react';
import { fetchClosedTrades } from '../services/bybitService';
import TradeDetailsDrawer from '../components/TradeDetailsDrawer';
import ClosedTradesStats from '../components/ClosedTradesStats';

export default function ClosedTrades() {
  const [trades, setTrades] = useState([]);
  const [loading, setLoading] = useState(true);
  const [selectedTrade, setSelectedTrade] = useState(null);

  useEffect(() => {
    const accounts = JSON.parse(localStorage.getItem("brokerAccounts") || "[]");
    const activeAccount = accounts.find(acc => acc.status === "Active");

    if (!activeAccount) {
      console.warn("⚠️ Geen actieve broker account gevonden.");
      setLoading(false);
      return;
    }

    const { apiKey, apiSecret } = activeAccount;

    fetchClosedTrades(apiKey, apiSecret)
      .then(data => {
        setTrades(data.result?.list || []);
        setLoading(false);
      })
      .catch(err => {
        console.error("❌ Fout bij ophalen closed trades:", err);
        setLoading(false);
      });
  }, []);

  const formatDate = (timestamp) => {
    const date = new Date(Number(timestamp));
    return isNaN(date.getTime()) ? "—" : date.toLocaleString("en-US", {
      year: 'numeric', month: 'short', day: 'numeric',
      hour: '2-digit', minute: '2-digit'
    });
  };

  const calcPercentage = (entry, exit, side) => {
    const e = parseFloat(entry);
    const x = parseFloat(exit);
    if (!e || !x || e === 0) return 0;
    const direction = side === 'Buy' ? 1 : -1;
    return ((x - e) / e) * direction * 100;
  };

  return (
    <div className="p-6 text-white space-y-6">
      <h1 className="text-3xl font-bold">Closed Trades</h1>

      <ClosedTradesStats trades={trades} />

      {loading ? (
        <p>Laden...</p>
      ) : (
        <div className="overflow-x-auto">
          <table className="w-full text-sm text-left border-collapse">
            <thead className="text-cyan-400 border-b border-gray-600 text-xs uppercase">
              <tr>
                <th className="py-2 text-left">Symbol</th>
                <th className="py-2 text-left">Account</th>
                <th className="py-2 text-right">Qty</th>
                <th className="py-2 text-right">Side</th>
                <th className="py-2 text-right">Entry</th>
                <th className="py-2 text-right">Exit</th>
                <th className="py-2 text-right">% PNL</th>
                <th className="py-2 text-right">PNL</th>
                <th className="py-2 text-right">Time</th>
                <th className="py-2 text-right">Details</th>
              </tr>
            </thead>
            <tbody>
              {trades.map((t, i) => {
                const entry = parseFloat(t.entryPrice || t.avgEntryPrice || 0);
                const exit = parseFloat(t.avgExitPrice || 0);
                const percent = calcPercentage(entry, exit, t.side);
                const color = percent >= 0 ? "text-green-400" : "text-red-400";
                const sideLabel = t.side === "Buy" ? "Long" : "Short";
                const sideColor = t.side === "Buy" ? "text-green-400" : "text-red-400";


                return (
                  <tr key={i} className="border-b border-gray-800 hover:bg-gray-800 transition">
                    <td className="py-2 font-semibold">

                      {t.symbol}
                    </td>
                    <td className="py-2 text-left">
                      {JSON.parse(localStorage.getItem("brokerAccounts") || "[]").find(acc => acc.status === "Active")?.name || "Onbekend"}
                    </td>
                    <td className="py-2 text-right">{t.qty}</td>
                    <td className={`py-2 text-right font-medium ${sideColor}`}>{sideLabel}</td>
                    <td className="py-2 text-right">{entry?.toFixed(5)}</td>
                    <td className="py-2 text-right">{exit?.toFixed(5)}</td>
                    <td className={`py-2 text-right font-medium ${color}`}>{percent.toFixed(2)}%</td>
                    <td className={`py-2 text-right font-medium ${color}`}>${Math.abs(parseFloat(t.closedPnl)).toFixed(2)}</td>
                    <td className="py-2 text-right">{formatDate(t.createdTime)}</td>
                    <td className="py-2 text-right">
                      <button onClick={() => setSelectedTrade(t)} className="text-cyan-400 hover:underline text-xs">
                        Trade details
                      </button>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      )}
      <TradeDetailsDrawer trade={selectedTrade} onClose={() => setSelectedTrade(null)} />
    </div>
  );
}
