#!/bin/bash

# 📍 CONTROLEREN of script in frontend-map wordt uitgevoerd
if [ ! -f "index.html" ] || [ ! -f "tailwind.config.js" ] || [ ! -d "src" ]; then
  echo "❌ Fout: Dit script moet worden uitgevoerd vanuit de frontend-map (waar index.html, tailwind.config.js en src/ staan)."
  exit 1
fi

echo "✅ Frontend-map bevestigd, doorgaan met stylingupdate..."

# ✅ Voeg Barlow toe aan index.html als nog niet aanwezig
if ! grep -q "fonts.googleapis.com/css2?family=Barlow" index.html; then
  sed -i '' '/<head>/a\
  <link href="https://fonts.googleapis.com/css2?family=Barlow:wght@300;400;600;700&display=swap" rel="stylesheet">
  ' index.html
  echo "✅ Google Font 'Barlow' toegevoegd aan index.html"
fi

# ✅ Voeg fontFamily toe aan tailwind.config.js als niet aanwezig
if ! grep -q "fontFamily" tailwind.config.js; then
  sed -i '' '/extend: {/a\
    fontFamily: {\n      sans: ["Barlow", "sans-serif"],\n    },
  ' tailwind.config.js
  echo "✅ fontFamily toegevoegd aan tailwind.config.js"
fi

# ✅ Update index.css
cat > src/index.css << 'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  @apply font-sans bg-white text-black transition-colors duration-300;
}
.dark body {
  @apply bg-zinc-900 text-white;
}
EOF

# ✅ Update Sidebar.tsx met betere styling
cat > src/components/Sidebar.tsx << 'EOF'
import React from 'react';
import { NavLink } from 'react-router-dom';
import { routes } from '../config/routesConfig';

export default function Sidebar() {
  const linkClass = ({ isActive }: { isActive: boolean }) =>
    \`block px-4 py-2 rounded-md transition-all duration-300 hover:bg-cyan-700 hover:shadow-lg \${isActive ? 'bg-cyan-500 text-white font-bold shadow-inner' : 'text-white'}\`;

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
            <NavLink key={path} to={\`/\${path}\`} className={linkClass}>
              {title}
            </NavLink>
          )
        )}
      </nav>
    </aside>
  );
}
EOF

# ✅ Update Header.tsx met toggle knop
cat > src/components/Header.tsx << 'EOF'
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
EOF

echo "✅ UI volledig bijgewerkt met: font, thema-knop, donkere modus, diepte en animaties!"
echo "ℹ️ Start je dev server opnieuw met: npm run dev"
