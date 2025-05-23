# Create an improved setup-and-run.sh script with refined frontend start logic
improved_script_content = """#!/usr/bin/env bash
set -euo pipefail

# Pas deze paden aan als jouw structuur anders is
BACKEND_DIR="./backend"
FRONTEND_DIR="./frontend"

echo "=== 📦 Backend setup ==="
cd "$BACKEND_DIR"

# 1) Virtuele omgeving aanmaken (als deze nog niet bestaat)
if [ ! -d "venv" ]; then
  echo "🔧 Maak Python venv aan..."
  python3 -m venv venv
fi

# 2) Venv activeren
# shellcheck disable=SC1091
source venv/bin/activate

# 3) Dependencies installeren, op basis van wat er ligt
if [ -f "requirements.txt" ]; then
  echo "📄 requirements.txt gevonden, installeer via pip..."
  pip install --upgrade pip
  pip install -r requirements.txt

elif [ -f "pyproject.toml" ]; then
  echo "📦 pyproject.toml gevonden, installeer via Poetry..."
  if ! command -v poetry &> /dev/null; then
    echo "❌ poetry niet geïnstalleerd. Installeren met: pip install poetry"
    exit 1
  fi
  poetry install

elif [ -f "Pipfile" ]; then
  echo "📦 Pipfile gevonden, installeer via Pipenv..."
  if ! command -v pipenv &> /dev/null; then
    echo "❌ pipenv niet geïnstalleerd. Installeren met: pip install pipenv"
    exit 1
  fi
  pipenv install --dev

else
  echo "⚠️ Geen requirements.txt, pyproject.toml of Pipfile gevonden."
  echo "   Je zult dependencies handmatig moeten installeren."
fi

# 4) Start backend in background (mits uvicorn aanwezig)
if command -v uvicorn &> /dev/null; then
  echo "🟢 Start Uvicorn..."
  uvicorn main:app --reload --app-dir src &
  BACKEND_PID=$!
else
  echo "⚠️ uvicorn niet gevonden in je venv, overslaan."
  BACKEND_PID=0
fi

cd ..

echo
echo "=== 🌐 Frontend setup ==="
cd "$FRONTEND_DIR"

# 5) Node-modules installeren (als package.json bestaat)
if [ -f "package.json" ]; then
  echo "🔧 Installeer Node.js dependencies..."
  npm install
else
  echo "⚠️ package.json niet gevonden, frontend-installs overslaan."
fi

# 6) Start frontend in background
# Probeer npm run dev, anders npx vite
if command -v npm &> /dev/null && grep -q '"dev"' package.json; then
  echo "🟢 Start npm run dev..."
  npm run dev &
  FRONTEND_PID=$!
elif command -v npx &> /dev/null; then
  echo "🟢 Start Vite via npx..."
  npx vite &
  FRONTEND_PID=$!
else
  echo "⚠️ Geen dev script of Vite beschikbaar, frontend overslaan."
  FRONTEND_PID=0
fi

echo
echo "✅ Setup voltooid!"
[ $BACKEND_PID -ne 0 ] && echo "  - Backend PID: $BACKEND_PID"
[ $FRONTEND_PID -ne 0 ] && echo "  - Frontend PID: $FRONTEND_PID"
echo
echo "Gebruik Ctrl+C om beide servers te stoppen."

# Houd script levend voor de draaiende processen
if [ $BACKEND_PID -ne 0 ] && [ $FRONTEND_PID -ne 0 ]; then
  wait $BACKEND_PID $FRONTEND_PID
elif [ $BACKEND_PID -ne 0 ]; then
  wait $BACKEND_PID
elif [ $FRONTEND_PID -ne 0 ]; then
  wait $FRONTEND_PID
fi
"""

file_path = '/mnt/data/setup-and-run.sh'
with open(file_path, 'w') as f:
    f.write(improved_script_content)

file_path
