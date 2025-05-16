#!/bin/bash

echo "🔧 Voeg debug logging toe aan backend route /api/bybit/balance..."

TARGET_FILE="./backend/src/routes/bybit_trades.py"

if [ ! -f "$TARGET_FILE" ]; then
  echo "❌ Bestand niet gevonden: $TARGET_FILE"
  exit 1
fi

# Voeg debug logging toe als het nog niet bestaat
if ! grep -q 'print("✅ Request ontvangen op /api/bybit/balance' "$TARGET_FILE"; then
  /usr/bin/sed -i '' '/@router.post(".*\/balance.*")/,/async def get_balance(request: Request):/{
  /async def get_balance(request: Request):/a\
\
    print("✅ Request ontvangen op /api/bybit/balance")\
    print("Headers:", request.headers)\
    body = await request.body()\
    print("Body:", body.decode(\"utf-8\"))
  }' "$TARGET_FILE"

  echo "✅ Debug logging toegevoegd aan $TARGET_FILE"
else
  echo "ℹ️ Logging was al aanwezig in $TARGET_FILE"
fi

echo "🔁 Herstart nu je backend met:"
echo "cd backend && source venv/bin/activate && uvicorn main:app --reload --app-dir src"
