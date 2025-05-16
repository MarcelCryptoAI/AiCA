#!/bin/bash

echo "🔧 Pas frontend balans-parser aan in BrokerAccounts.jsx..."

# Zoekbestand en patch het ophalen/parsen van balance info
target="frontend/src/pages/BrokerAccounts.jsx"

# Controleer of bestand bestaat
if [ ! -f "$target" ]; then
  echo "❌ Bestand $target bestaat niet!"
  exit 1
fi

# Vervang parsing logic
sed -i '' 's/const info = json.result?.list?.\[0\];/const equity = parseFloat(json?.result?.list?.[0]?.totalEquity || 0);\
const available = parseFloat(json?.result?.list?.[0]?.totalAvailableBalance || 0);\
const info = { equity, available };/' "$target"

echo "✅ Frontend parsing van balansinformatie is aangepast!"
echo "💡 Herstart frontend met: cd frontend && npm run dev"
