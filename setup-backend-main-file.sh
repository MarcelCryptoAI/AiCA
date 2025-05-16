#!/bin/bash

echo "🛠️ Maak backend/src/main.py aan met FastAPI setup..."

# Stap 1: Zorg dat backend/src bestaat
mkdir -p ./backend/src/routes
touch ./backend/src/__init__.py

# Stap 2: Maak main.py met correcte FastAPI configuratie
cat > ./backend/src/main.py << 'EOF'
from fastapi import FastAPI
from routes.bybit_trades import router as bybit_router

app = FastAPI()
app.include_router(bybit_router)
EOF

echo ""
echo "✅ Bestand backend/src/main.py is aangemaakt!"
echo "✅ Bestand backend/src/__init__.py toegevoegd!"
echo ""
echo "📍 Plaats dit script altijd in de ROOT van je projectmap:"
echo "(De map waar je de mappen 'backend' en 'frontend' ziet staan)"
echo ""
echo "🔄 Start nu je backend met:"
echo "cd backend"
echo "source venv/bin/activate"
echo "uvicorn main:app --reload --app-dir src"
