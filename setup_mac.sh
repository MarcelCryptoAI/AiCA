#!/bin/bash

echo "🍏 Start Crypto WebApp Setup op macOS..."

# 1. Projectstructuur
mkdir -p backend frontend
touch Makefile

# 2. Backend
echo "🔧 Python backend instellen..."
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

# 3. Frontend (React + TypeScript + Tailwind + SWC)
echo "⚛️ Frontend setup..."
cd frontend
npm create vite@latest . -- --template react-ts
npm install
npm install -D tailwindcss postcss autoprefixer eslint prettier eslint-plugin-react eslint-config-prettier
npx tailwindcss init -p

# Fix voor macOS sed
sed -i '' "s/content: \\[\\]/content: [\\\".\\/index.html\\\", \\\".\\/src/**/*.{js,ts,jsx,tsx}\\\"]/" tailwind.config.js

echo "@tailwind base;" > src/index.css
echo "@tailwind components;" >> src/index.css
echo "@tailwind utilities;" >> src/index.css

# Vite proxy
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

# 4. Makefile zonder gnome-terminal
cat > Makefile <<EOF
.PHONY: start backend frontend

start:
	@echo "📦 Start backend in venster 1..."
	osascript -e 'tell app "Terminal" to do script "cd backend && source venv/bin/activate && python app.py"'
	@echo "⚛️ Start frontend in venster 2..."
	osascript -e 'tell app "Terminal" to do script "cd frontend && npm run dev"'

backend:
	cd backend && source venv/bin/activate && python app.py

frontend:
	cd frontend && npm run dev
EOF

echo "✅ Setup compleet. Gebruik 'make start' en open http://localhost:5173"
