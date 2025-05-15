import React from 'react';
import { NavLink } from 'react-router-dom';
import { routes } from '../config/routesConfig';

export default function Sidebar() {
  const linkClass = ({ isActive }: { isActive: boolean }) =>
    `block px-4 py-2 rounded-md transition-all duration-300 hover:bg-cyan-700 hover:shadow-lg ${isActive ? 'bg-cyan-500 text-white font-bold shadow-inner' : 'text-white'}`;

  return (
    <aside className="w-64 bg-zinc-900 p-4 space-y-3 shadow-2xl flex flex-col items-start font-sans min-h-screen">
      <div className="w-full flex justify-center mb-6">
        <img src="/logo.png" alt="AI Crypto Analyser" className="w-32 h-auto" />
      </div>
      <h2 className="text-xl font-bold text-white px-2">Menu</h2>
      <nav className="w-full space-y-1">
        {routes.map(({ path, title, isHeader }) =>
          isHeader ? (
            <div key={title} className="text-cyan-400 font-semibold uppercase text-xs tracking-wide mt-6 px-2">
              {title}
            </div>
          ) : (
            <NavLink key={path} to={`/${path}`} className={linkClass}>
              {title}
            </NavLink>
          )
        )}
      </nav>
    </aside>
  );
}
