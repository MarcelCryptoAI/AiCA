#!/bin/bash

echo "🔧 Herstel backend structuur voor correcte FastAPI + uvicorn start"

# 1. __init__.py toevoegen zodat src een module wordt
touch ./backend/src/__init__.py
echo "✅ Bestand __init__.py toegevoegd aan backend/src/"

# 2. Check of main.py FastAPI setup bevat
MAIN_FILE="./backend/src/main.py"
if ! grep -q "FastAPI" "$MAIN_FILE"; then
  echo "❌ Waarschuwing: FastAPI niet gevonden in main.py. Controleer handmatig."
else
  echo "✅ FastAPI import gevonden in main.py"
fi

# 3. Toon correcte startinstructies
echo ""
echo "🚀 Start nu je backend met dit commando:"
echo ""
echo "cd backend"
echo "source venv/bin/activate"
echo "uvicorn main:app --reload --app-dir src"
echo ""
