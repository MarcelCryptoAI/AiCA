import React from 'react';
import { NavLink } from 'react-router-dom';

export default function Sidebar() {
  const linkClass = ({ isActive }: { isActive: boolean }) =>
    \`block px-4 py-2 rounded-lg text-white hover:bg-neon-cyan \${isActive ? 'bg-neon-cyan text-black font-bold' : ''}\`;

  return (
    <aside className="w-64 bg-dark-panel p-4 space-y-2">
      <h2 className="text-2xl font-bold mb-4 text-neon-cyan">Menu</h2>
      <NavLink to="/dashboard" className={linkClass}>Dashboard</NavLink>
      <NavLink to="/trades" className={linkClass}>Trades</NavLink>
      <NavLink to="/signals" className={linkClass}>Signals</NavLink>
      <NavLink to="/accounts" className={linkClass}>Accounts</NavLink>
    </aside>
  );
}
