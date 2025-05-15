import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Dashboard from './pages/Dashboard';
import OpenTrades from './pages/OpenTrades';
import ClosedTrades from './pages/ClosedTrades';
import BrokerAccounts from './pages/BrokerAccounts';
import Assets from './pages/Assets';
import TheAIAnalyzer from './pages/TheAIAnalyzer';
import SignalBots from './pages/SignalBots';
import DCABots from './pages/DCABots';
import GridBots from './pages/GridBots';
import TradingviewBots from './pages/TradingviewBots';
import LiveTradingTerminal from './pages/LiveTradingTerminal';
import CopyTrade from './pages/CopyTrade';
import Forum from './pages/Forum';
import SignalSubscriptions from './pages/SignalSubscriptions';
import Watchlists from './pages/Watchlists';
import Settings from './pages/Settings';
import Upgrade from './pages/Upgrade';
import Billing from './pages/Billing';

export default function App() {
  return (
    <Router>
      <div className="flex">
        <Sidebar />
        <div className="flex-grow bg-gray-900 min-h-screen p-4">
          <Routes>
            <Route path="/" element={<Dashboard />} />
            <Route path="/open-trades" element={<OpenTrades />} />
            <Route path="/closed-trades" element={<ClosedTrades />} />
            <Route path="/broker-accounts" element={<BrokerAccounts />} />
            <Route path="/assets" element={<Assets />} />
            <Route path="/the-ai-analyzer" element={<TheAIAnalyzer />} />
            <Route path="/signal-bots" element={<SignalBots />} />
            <Route path="/dca-bots" element={<DCABots />} />
            <Route path="/grid-bots" element={<GridBots />} />
            <Route path="/tradingview-bots" element={<TradingviewBots />} />
            <Route path="/live-trading-terminal" element={<LiveTradingTerminal />} />
            <Route path="/copy-trade" element={<CopyTrade />} />
            <Route path="/forum" element={<Forum />} />
            <Route path="/signal-subscriptions" element={<SignalSubscriptions />} />
            <Route path="/watchlists" element={<Watchlists />} />
            <Route path="/settings" element={<Settings />} />
            <Route path="/upgrade" element={<Upgrade />} />
            <Route path="/billing" element={<Billing />} />
          </Routes>
        </div>
      </div>
    </Router>
  );
}
