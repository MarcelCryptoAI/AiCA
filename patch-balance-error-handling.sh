#!/bin/bash

echo "🛠️ Voeg foutafhandeling toe aan /api/bybit/balance endpoint..."

# Patch het bybit_trades.py bestand in de backend
cat > ./backend/src/routes/bybit_trades.py << 'EOF'
from fastapi import APIRouter
from pydantic import BaseModel
import requests
import time
import hmac
import hashlib

router = APIRouter()

class AuthRequest(BaseModel):
    apiKey: str
    apiSecret: str

def sign_request(api_key, api_secret):
    timestamp = str(int(time.time() * 1000))
    sign = hmac.new(
        bytes(api_secret, "utf-8"),
        bytes(timestamp + api_key, "utf-8"),
        hashlib.sha256,
    ).hexdigest()
    return {
        "X-BAPI-API-KEY": api_key,
        "X-BAPI-SIGN": sign,
        "X-BAPI-TIMESTAMP": timestamp,
        "X-BAPI-RECV-WINDOW": "5000",
        "Content-Type": "application/json"
    }

@router.post("/api/bybit/balance")
async def get_wallet_balance(body: AuthRequest):
    try:
        url = "https://api.bybit.com/v5/account/wallet-balance?accountType=UNIFIED"
        headers = sign_request(body.apiKey, body.apiSecret)
        response = requests.get(url, headers=headers)

        if response.status_code != 200:
            return {
                "error": True,
                "status": response.status_code,
                "message": "Bybit API returned error",
                "details": response.text
            }

        data = response.json()
        if "result" not in data or "list" not in data["result"]:
            return {
                "error": True,
                "message": "Unexpected response format",
                "raw": data
            }

        return data

    except Exception as e:
        print("❌ Fout in /api/bybit/balance:", e)
        return {
            "error": True,
            "message": "Internal server error",
            "details": str(e)
        }
EOF

echo "✅ /api/bybit/balance heeft nu try/catch foutafhandeling en logt fouten naar console"
echo ""
echo "📍 Herstart je backend nu met:"
echo "cd backend"
echo "source venv/bin/activate"
echo "uvicorn main:app --reload --app-dir src"
