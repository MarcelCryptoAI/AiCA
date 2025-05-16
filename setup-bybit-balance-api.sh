#!/bin/bash

echo "💰 Voeg /api/bybit/balance endpoint toe voor unified + derivatives saldo"

# Zorg dat de routes map bestaat
mkdir -p ./backend/src/routes

# Voeg balansroute toe
cat >> ./backend/src/routes/bybit_trades.py << 'EOF'

@router.post("/api/bybit/balance")
async def get_wallet_balance(body: AuthRequest):
    url = "https://api.bybit.com/v5/account/wallet-balance?accountType=UNIFIED"
    headers = sign_request(body.apiKey, body.apiSecret)
    response = requests.get(url, headers=headers)
    return response.json()
EOF

echo "✅ API route '/api/bybit/balance' toegevoegd aan backend/src/routes/bybit_trades.py"
echo ""
echo "📍 Start je backend opnieuw met:"
echo "cd backend"
echo "source venv/bin/activate"
echo "uvicorn main:app --reload --app-dir src"
