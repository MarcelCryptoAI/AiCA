#!/bin/bash

echo "✅ Laden van .env variabelen..."

# Pad naar .env bestand (relatief vanaf dit script)
ENV_FILE="../.env"

# Check of bestand bestaat
if [ ! -f "$ENV_FILE" ]; then
  echo "❌ .env bestand niet gevonden op: $ENV_FILE"
  exit 1
fi

# Laad variabelen
export $(grep -v '^#' "$ENV_FILE" | xargs)

# Check vereiste variabelen
if [ -z "$BYBIT_API_KEY" ] || [ -z "$BYBIT_API_SECRET" ]; then
  echo "❌ BYBIT_API_KEY of BYBIT_API_SECRET ontbreekt in .env"
  exit 1
fi

echo "🔁 Virtuele omgeving activeren..."
source venv/bin/activate

echo "🚀 Starten van FastAPI backend met environment geladen..."
uvicorn src.main:app --reload
