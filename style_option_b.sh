#!/bin/bash

echo "🎨 Pas ontwerp aan volgens optie B (neon glow, donker, modern)..."

cd frontend

# 1. Voeg aangepaste Tailwind-config toe voor neon effects en fonts
cat > tailwind.config.js <<'EOF'
/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./index.html", "./src/**/*.{js,ts,jsx,tsx}"],
  theme: {
    extend: {
      fontFamily: {
        sans: ['"Orbitron"', 'sans-serif'],
      },
      colors: {
        neon: {
          blue: '#00f0ff',
          cyan: '#00ffe0',
          purple: '#9f00ff',
        },
        dark: {
          bg: '#0a0f1e',
          panel: '#111827',
        },
      },
      boxShadow: {
        neon: '0 0 15px #00f0ff, 0 0 30px #00ffe0',
      },
    },
  },
  plugins: [],
};
EOF

# 2. Voeg Google Font (Orbitron) toe aan index.html
sed -i '' '/<title>/i\
  <link href="https://fonts.googleapis.com/css2?family=Orbitron:wght@400;600&display=swap" rel="stylesheet">
' index.html

# 3. Pas index.css aan voor globale stijling
cat > src/index.css <<'EOF'
@tailwind base;
@tailwind components;
@tailwind utilities;

body {
  @apply bg-dark-bg text-neon-blue font-sans;
}
EOF

# 4. Pas Dashboard-pagina aan in optie B-stijl
cat > src/pages/Dashboard.tsx <<'EOL'
import React from 'react';

export default function Dashboard() {
  return (
    <div className="space-y-6">
      <h1 className="text-4xl font-bold text-neon-cyan drop-shadow-[0_0_10px_#00ffe0]">Welcome, &lt;name&gt;</h1>
      <div className="grid grid-cols-3 gap-6">
        <div className="bg-dark-panel p-6 rounded-2xl shadow-neon text-center">
          <p className="text-3xl font-bold">23</p>
          <p className="text-sm text-neon-purple">ADVS / SHORT</p>
        </div>
        <div className="bg-dark-panel p-6 rounded-2xl shadow-neon text-center">
          <p className="text-3xl font-bold">61.5%</p>
          <p className="text-sm text-neon-purple">AVG / LOWS</p>
        </div>
        <div className="bg-dark-panel p-6 rounded-2xl shadow-neon text-center">
          <p className="text-3xl font-bold">73.2%</p>
          <p className="text-sm text-neon-purple">AVG-IBB</p>
        </div>
      </div>
    </div>
  );
}
EOL

echo "✅ Ontwerp aangepast aan stijl van optie B met neon glow en donker thema."
