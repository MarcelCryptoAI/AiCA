# Genereer een volledig installatie- en opstartscript met TypeScript + SWC + Flask + Makefile + ESLint + Prettier

setup_script = """#!/bin/bash

echo "🚀 Start volledige Crypto WebApp Setup..."

# ------------------------------
# 1. BENODIGDHEDEN INSTALLEREN
# ------------------------------
echo "📦 Systeemvereisten installeren..."
sudo apt-get update
sudo apt-get install -y python3 python3-pip python3-venv git curl npm

# ------------------------------
# 2. MAPPENSTRUCTUUR AANMAKEN
# ------------------------------
echo "📁 Projectstructuur maken..."
mkdir -p backend frontend
touch Makefile

# ------------------------------
# 3. BACKEND SETUP
# ------------------------------
echo "🧠 Backend setup (Flask)..."
cd backend
python3 -m venv venv
source venv/bin/activate
pip install flask flask-cors
cat > app.py <<EOF
from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

@app.route('/')
def index():
    return jsonify({'message': 'Backend running'})

if __name__ == '__main__':
    app.run(debug=True)
EOF
deactivate
cd ..

# ------------------------------
# 4. FRONTEND SETUP (VITE + REACT + TYPESCRIPT + SWC)
# ------------------------------
echo "⚛️ Frontend setup (Vite + React + TS + SWC)..."
cd frontend
npm create vite@latest . -- --template react-ts
npm install
npm install -D tailwindcss postcss autoprefixer eslint prettier eslint-plugin-react eslint-config-prettier
npx tailwindcss init -p

# Tailwind content path instellen
sed -i "s/content: \\[\\]/content: [\\\".\\/index.html\\\", \\\".\\/src/**/*.{js,ts,jsx,tsx}\\\"]/" tailwind.config.js

# Tailwind imports
echo "@tailwind base;" > src/index.css
echo "@tailwind components;" >> src/index.css
echo "@tailwind utilities;" >> src/index.css

# Vite proxy instellen naar Flask backend
cat > vite.config.ts <<EOF
import {{ defineConfig }} from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({{
  plugins: [react()],
  server: {{
    proxy: {{
      '/api': 'http://localhost:5000'
    }}
  }}
}})
EOF

# Sidebar component
mkdir -p src/components src/pages
cat > src/components/Sidebar.tsx <<'EOL'
import React from 'react';
import { Link } from 'react-router-dom';

export default function Sidebar() {
  return (
    <div className="w-64 h-screen bg-gray-900 text-white p-4">
      <h2 className="text-xl font-bold mb-6">Welkom, &lt;naam&gt;</h2>
      <nav className="space-y-2">
        <Link to="/dashboard" className="block hover:bg-gray-800 p-2 rounded">Dashboard</Link>
        <div>
          <p className="font-semibold mt-4">Trades</p>
          <Link to="/trades/open" className="block hover:bg-gray-800 p-2 rounded">Open Trades</Link>
          <Link to="/trades/closed" className="block hover:bg-gray-800 p-2 rounded">Closed Trades</Link>
        </div>
        <div>
          <p className="font-semibold mt-4">PORTFOLIO</p>
          <Link to="/portfolio/accounts" className="block hover:bg-gray-800 p-2 rounded">Exchange accounts</Link>
          <Link to="/portfolio/assets" className="block hover:bg-gray-800 p-2 rounded">Assets</Link>
        </div>
        <div>
          <p className="font-semibold mt-4">TRADING</p>
          <Link to="/trading/ai" className="block hover:bg-gray-800 p-2 rounded">Ai Powered Trading</Link>
          <Link to="/trading/backtesting" className="block hover:bg-gray-800 p-2 rounded">Backtesting</Link>
          <Link to="/trading/signald" className="block hover:bg-gray-800 p-2 rounded">Signald</Link>
          <Link to="/trading/signalbots" className="block hover:bg-gray-800 p-2 rounded">Signal Bots</Link>
          <Link to="/trading/dca" className="block hover:bg-gray-800 p-2 rounded">DCA Bots</Link>
          <Link to="/trading/grid" className="block hover:bg-gray-800 p-2 rounded">GRID Bots</Link>
          <Link to="/trading/tradingview" className="block hover:bg-gray-800 p-2 rounded">Traidingview Bots</Link>
        </div>
        <div>
          <p className="font-semibold mt-4">SETTINGS</p>
          <Link to="/settings/general" className="block hover:bg-gray-800 p-2 rounded">General</Link>
          <Link to="/settings/api" className="block hover:bg-gray-800 p-2 rounded">API keys</Link>
          <Link to="/settings/subscription" className="block hover:bg-gray-800 p-2 rounded">Subscription</Link>
        </div>
      </nav>
    </div>
  );
}
EOL

cd ..

# ------------------------------
# 5. MAKEFILE TOEVOEGEN
# ------------------------------
cat > Makefile <<EOF
.PHONY: start backend frontend

start:
	@echo "🚀 Starting backend and frontend..."
	@gnome-terminal -- bash -c "cd backend && source venv/bin/activate && python app.py; exec bash" &
	@gnome-terminal -- bash -c "cd frontend && npm run dev; exec bash"

backend:
	cd backend && source venv/bin/activate && python app.py

frontend:
	cd frontend && npm run dev
EOF

echo "✅ Setup voltooid. Start nu met: make start (of open http://localhost:5173)"
"""

# Bestand opslaan
script_path = "/mnt/data/setup_crypto_webapp.sh"
with open(script_path, "w") as f:
    f.write(setup_script)

script_path
