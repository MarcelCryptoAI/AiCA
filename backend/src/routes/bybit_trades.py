import time
import hmac
import hashlib
import requests
import traceback
from fastapi import APIRouter, Request
from pydantic import BaseModel
def log_to_file(msg): print(msg)

router = APIRouter()

class AuthRequest(BaseModel):
    apiKey: str
    apiSecret: str

def sign_request(api_key, api_secret, query: str = "accountType=UNIFIED"):
    timestamp = str(int(time.time() * 1000))
    recv_window = "5000"
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

@router.post("/api/bybit/open-trades")
async def get_open_trades(body: AuthRequest, request: Request):
    try:
        log_to_file("🔑 Open Trades Key: " + body.apiKey)
        query = "category=linear&accountType=UNIFIED"
        url = f"https://api.bybit.com/v5/position/list?{query}"
        headers = sign_request(body.apiKey, body.apiSecret, query)
        response = requests.get(url, headers=headers)
        log_to_file(f"⬅️ Open Trades status {response.status_code}")
        data = response.json()
        log_to_file("📦 Open Trades JSON: " + str(data))
        if response.status_code != 200 or "result" not in data or "list" not in data["result"]:
            return {"error": True, "message": "Bybit error Open Trades", "details": data}
        return data
    except Exception as e:
        log_to_file("🔥 Exception Open Trades: " + str(e))
        log_to_file(traceback.format_exc())
        return {"error": True, "message": "Internal server error", "details": str(e)}

@router.post("/api/bybit/closed-trades")
async def get_closed_trades(body: AuthRequest, request: Request):
    try:
        log_to_file("🔑 Closed Trades Key: " + body.apiKey)
        query = "category=linear&accountType=UNIFIED&limit=50"
        url = f"https://api.bybit.com/v5/position/closed-pnl?{query}"
        headers = sign_request(body.apiKey, body.apiSecret, query)
        response = requests.get(url, headers=headers)
        log_to_file(f"⬅️ Closed Trades status {response.status_code}")
        data = response.json()
        log_to_file("📦 Closed Trades JSON: " + str(data))
        if response.status_code != 200 or "result" not in data or "list" not in data["result"]:
            return {"error": True, "message": "Bybit error Closed Trades", "details": data}
        return data
    except Exception as e:
        log_to_file("🔥 Exception Closed Trades: " + str(e))
        log_to_file(traceback.format_exc())
        return {"error": True, "message": "Internal server error", "details": str(e)}

@router.post("/api/bybit/balance")
async def get_all_balances(body: AuthRequest, request: Request):
    try:
        account_types = ["UNIFIED", "FUND", "CONTRACT", "SPOT"]
        results = []
        for acc_type in account_types:
            query = f"accountType={acc_type}"
            url = f"https://api.bybit.com/v5/account/wallet-balance?{query}"
            headers = sign_request(body.apiKey, body.apiSecret, query)
            response = requests.get(url, headers=headers)
            data = response.json()
            results.append({
                "accountType": acc_type,
                "status": response.status_code,
                "balanceData": data.get("result", {}),
                "raw": data
            })
        return {"status": "ok", "results": results}
    except Exception as e:
        log_to_file("🔥 Exception Balance: " + str(e))
        log_to_file(traceback.format_exc())
        return {"error": True, "message": "Balance ophalen mislukt", "details": str(e)}
