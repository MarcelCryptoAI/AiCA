#!/bin/bash

echo "🧠 Toevoegen van Barlow lettertype aan index.html..."
# Voeg Google Fonts link toe aan head als die nog niet bestaat
if ! grep -q "fonts.googleapis.com/css2?family=Barlow" src/index.html; then
  sed -i '' '/<head>/a\
  <link href="https://fonts.googleapis.com/css2?family=Barlow:wght@300;400;600;700&display=swap" rel="stylesheet">
  ' src/index.html
  echo "✅ Google Font 'Barlow' toegevoegd aan <head> van index.html"
else
  echo "ℹ️ Font 'Barlow' stond al in index.html"
fi

echo "🎨 Updaten van tailwind.config.js met fontFamily..."
# Voeg fontFamily toe aan Tailwind config
if ! grep -q "fontFamily" tailwind.config.js; then
  sed -i '' '/extend: {/a\
    fontFamily: {\n      sans: ["Barlow", "sans-serif"],\n    },
  ' tailwind.config.js
  echo "✅ 'Barlow' toegevoegd aan tailwind.config.js"
else
  echo "ℹ️ FontFamily stond al in tailwind.config.js – controleer of Barlow is toegevoegd"
fi

echo "💅 Aanpassen van index.css om font toe te passen op body..."
cat > src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  @apply font-sans;
}
EOF

echo "🧱 Bonus: Sidebar headers met Barlow en styling updaten..."
cat > src/components/Sidebar.tsx << 'EOF'
import React from 'react';
import { NavLink } from 'react-router-dom';
import { routes } from '../config/routesConfig';

export default function Sidebar() {
  const linkClass = ({ isActive }: { isActive: boolean }) =>
    `block px-4 py-2 rounded-md transition duration-300 hover:bg-cyan-700 hover:shadow-md ${
      isActive ? 'bg-cyan-500 text-white font-bold shadow-inner' : 'text-white'
    }`;

  return (
    <aside className="w-64 bg-zinc-900 p-4 space-y-3 shadow-2xl flex flex-col items-start font-sans">
      <div className="w-full flex justify-center mb-6">
        <img src="/logo.png" alt="AI Crypto Analyser" className="w-32 h-auto" />
      </div>
      <h2 className="text-xl font-bold text-white px-2">Menu</h2>
      <nav className="w-full space-y-1">
        {routes.map(({ path, title, isHeader }) =>
          isHeader ? (
            <div key={title} className="text-cyan-400 font-semibold font-sans uppercase text-xs tracking-wide mt-6 px-2">
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
EOF

echo "✅ Voltooid. Start nu je app met: npm run dev"
