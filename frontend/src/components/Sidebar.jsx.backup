import { NavLink } from 'react-router-dom';

const navItems = [
  { path: "/", title: "Dashboard", type: "link" },
  { path: "/open-trades", title: "Open Trades", type: "link" },
  { path: "/closed-trades", title: "Closed Trades", type: "link" },
  { title: "MY PORTFOLIO", type: "section" },
  { path: "/broker-accounts", title: "Broker Accounts", type: "link" },
  { path: "/assets", title: "Assets", type: "link" },
  { title: "TRADING", type: "section" },
  { path: "/the-ai-analyzer", title: "The AI Analyzer", type: "link" },
  { path: "/signal-bots", title: "Signal Bots", type: "link" },
  { path: "/dca-bots", title: "DCA Bots", type: "link" },
  { path: "/grid-bots", title: "Grid Bots", type: "link" },
  { path: "/tradingview-bots", title: "Tradingview Bots", type: "link" },
  { path: "/live-trading-terminal", title: "Live Trading Terminal", type: "link" },
  { path: "/copy-trade", title: "Copy Trade", type: "link" },
  { title: "COMMUNITY", type: "section" },
  { path: "/forum", title: "Forum", type: "link" },
  { path: "/signal-subscriptions", title: "Signal Subscriptions", type: "link" },
  { path: "/watchlists", title: "Watchlists", type: "link" },
  { title: "MY ACCOUNT", type: "section" },
  { path: "/settings", title: "Settings", type: "link" },
  { path: "/upgrade", title: "Upgrade", type: "link" },
  { path: "/billing", title: "Billing", type: "link" },
];

export default function Sidebar() {
  const linkClass = ({ isActive }) =>
    `block px-4 py-2 rounded-md transition-all duration-300 hover:bg-cyan-700 hover:shadow-lg ${isActive ? 'bg-cyan-500 text-white font-bold shadow-inner' : 'text-white'}`;

  return (
    <div className="bg-gray-800 min-h-screen w-64 p-4 space-y-2 text-white">
      <h2 className="text-lg font-bold mb-4">Menu</h2>
      {navItems.map((item, i) =>
        item.type === 'section' ? (
          <div key={i} className="mt-4 mb-1 text-cyan-400 text-xs font-bold uppercase">{item.title}</div>
        ) : (
          <NavLink key={item.path} to={item.path} className={linkClass}>
            {item.title}
          </NavLink>
        )
      )}
    </div>
  );
}
