#!/bin/bash

echo "🔍 Voeg uitgebreide debug logging toe aan /api/bybit/balance endpoint..."

# Overschrijf bybit_trades.py met volledige logging
cat > ./backend/src/routes/bybit_trades.py << 'EOF'
from fastapi import APIRouter, Request
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
async def get_wallet_balance(body: AuthRequest, request: Request):
    try:
        print("📥 Nieuwe balans-aanvraag ontvangen op /api/bybit/balance")
        print("🔑 API KEY:", body.apiKey)
        print("🔐 API SECRET:", body.apiSecret)
        print("🧾 Request headers:", dict(request.headers))

        url = "https://api.bybit.com/v5/account/wallet-balance?accountType=UNIFIED"
        headers = sign_request(body.apiKey, body.apiSecret)
        print("➡️ Headers naar Bybit:", headers)

        response = requests.get(url, headers=headers)
        print("⬅️ Bybit antwoordt met status:", response.status_code)

        if response.status_code != 200:
            print("❌ Foutresponse van Bybit:", response.text)
            return {
                "error": True,
                "status": response.status_code,
                "message": "Bybit API returned error",
                "details": response.text
            }

        data = response.json()
        print("📦 Ontvangen JSON:", data)

        if "result" not in data or "list" not in data["result"]:
            print("⚠️ Unexpected response format:", data)
            return {
                "error": True,
                "message": "Unexpected response format",
                "raw": data
            }

        return data

    except Exception as e:
        print("🔥 Exception tijdens balans ophalen:", str(e))
        return {
            "error": True,
            "message": "Internal server error",
            "details": str(e)
        }
EOF

echo "✅ Volledige logging toegevoegd aan /api/bybit/balance"
