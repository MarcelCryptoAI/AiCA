#!/bin/bash

echo "🧩 Voeg bybit_trades router toe aan backend/src/routes"

# Stap 1: Maak map aan
mkdir -p ./backend/src/routes

# Stap 2: Voeg Python bestand toe met juiste inhoud
cat > ./backend/src/routes/bybit_trades.py << 'EOF'
import requests
import time
import hmac
import hashlib
from fastapi import APIRouter
from pydantic import BaseModel

router = APIRouter()

class AuthRequest(BaseModel):
    apiKey: str
    apiSecret: str

def sign_request(api_key, api_secret):
    recv_window = "5000"
    timestamp = str(int(time.time() * 1000))
    signature_payload = f"{timestamp}{api_key}{recv_window}"
    signature = hmac.new(
        bytes(api_secret, "utf-8"),
        msg=bytes(signature_payload, "utf-8"),
        digestmod=hashlib.sha256
    ).hexdigest()

    headers = {
        "X-BYBIT-API-KEY": api_key,
        "X-BYBIT-SIGN": signature,
        "X-BYBIT-TIMESTAMP": timestamp,
        "X-BYBIT-RECV-WINDOW": recv_window,
        "Content-Type": "application/json"
    }
    return headers

@router.post("/api/bybit/open-trades")
async def get_open_positions(body: AuthRequest):
    url = "https://api.bybit.com/v5/position/list?category=linear"
    headers = sign_request(body.apiKey, body.apiSecret)
    response = requests.get(url, headers=headers)
    return response.json()

@router.post("/api/bybit/closed-trades")
async def get_closed_positions(body: AuthRequest):
    url = "https://api.bybit.com/v5/execution/list?category=linear&limit=50"
    headers = sign_request(body.apiKey, body.apiSecret)
    response = requests.get(url, headers=headers)
    return response.json()
EOF

echo "✅ routes/bybit_trades.py is aangemaakt."

# Stap 3: Herinner gebruiker aan juiste plek
echo ""
echo "📍 Plaats dit script in de ROOT van je project:"
echo "project-root/"
echo "├── backend/"
echo "│   └── src/"
echo "│       └── routes/bybit_trades.py ✅"
