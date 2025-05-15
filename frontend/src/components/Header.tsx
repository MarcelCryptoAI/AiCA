import React from 'react';

export default function Header() {
  const toggleTheme = () => {
    document.documentElement.classList.toggle('dark');
  };

  return (
    <header className="bg-white dark:bg-zinc-800 text-black dark:text-white p-4 shadow-md flex justify-between items-center font-sans">
      <h1 className="text-2xl font-bold text-cyan-400">Crypto Analyse Dashboard</h1>
      <button onClick={toggleTheme} className="bg-cyan-500 hover:bg-cyan-700 text-white px-4 py-2 rounded transition">
        Toggle Theme
      </button>
    </header>
  );
}
