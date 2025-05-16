#!/bin/bash

echo "🔧 Herstel bestand bybitService.js..."

# Stap 1: Zorg dat de map bestaat
mkdir -p ./frontend/src/services

# Stap 2: Voeg servicebestand toe
cat > ./frontend/src/services/bybitService.js << 'EOF'
export async function fetchOpenTrades(apiKey, apiSecret) {
  const res = await fetch("/api/bybit/open-trades", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ apiKey, apiSecret })
  });
  return await res.json();
}

export async function fetchClosedTrades(apiKey, apiSecret) {
  const res = await fetch("/api/bybit/closed-trades", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ apiKey, apiSecret })
  });
  return await res.json();
}
EOF

echo "✅ Bestand bybitService.js is aangemaakt in frontend/src/services/"
echo ""
echo "📍 Plaats en voer dit script uit vanuit de ROOT van je project:"
echo "(waar je 'frontend/' en 'backend/' ziet staan)"
