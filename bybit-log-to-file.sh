#!/bin/bash

echo "🛠️ Logging van balans-aanvragen naar balance.log"

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

def log_to_file(message: str):
    with open("balance.log", "a") as log_file:
        log_file.write(f"[LOG] {time.strftime('%Y-%m-%d %H:%M:%S')} — {message}\n")

def sign_request(api_key, api_secret):
    timestamp = str(int(time.time() * 1000))
    recv_window = "5000"
    query = "accountType=UNIFIED"
    origin_string = timestamp + api_key + recv_window + query
    sign = hmac.new(
        bytes(api_secret, "utf-8"),
        bytes(origin_string, "utf-8"),
        hashlib.sha256,
    ).hexdigest()
    return {
        "X-BAPI-API-KEY": api_key,
        "X-BAPI-SIGN": sign,
        "X-BAPI-TIMESTAMP": timestamp,
        "X-BAPI-RECV-WINDOW": recv_window,
        "Content-Type": "application/json"
    }

@router.post("/api/bybit/balance")
async def get_wallet_balance(body: AuthRequest, request: Request):
    try:
        log_to_file("🔑 API Key ontvangen: " + body.apiKey)
        url = "https://api.bybit.com/v5/account/wallet-balance?accountType=UNIFIED"
        headers = sign_request(body.apiKey, body.apiSecret)
        log_to_file("➡️ Headers: " + str(headers))

        response = requests.get(url, headers=headers)
        log_to_file("⬅️ Status: " + str(response.status_code))

        if response.status_code != 200:
            log_to_file("❌ Bybit Error Response: " + response.text)
            return {
                "error": True,
                "status": response.status_code,
                "message": "Bybit API returned error",
                "details": response.text
            }

        data = response.json()
        log_to_file("📦 Ontvangen JSON: " + str(data))

        if "result" not in data or "list" not in data["result"]:
            log_to_file("⚠️ Unexpected structure: " + str(data))
            return {
                "error": True,
                "message": "Unexpected response format",
                "raw": data
            }

        return data

    except Exception as e:
        log_to_file("🔥 Exception: " + str(e))
        return {
            "error": True,
            "message": "Internal server error",
            "details": str(e)
        }
EOF

echo "✅ Bestandspad logging ingesteld. Herstart je backend nu."
