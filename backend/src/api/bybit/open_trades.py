import os
from fastapi import APIRouter, HTTPException, Query
from typing import Optional
from pybit.unified_trading import HTTP

router = APIRouter(prefix="/api/bybit")

api_key = os.getenv("BYBIT_API_KEY")
api_secret = os.getenv("BYBIT_API_SECRET")

if not api_key or not api_secret:
    raise RuntimeError("BYBIT_API_KEY and BYBIT_API_SECRET must be set in environment")

client = HTTP(api_key=api_key, api_secret=api_secret)

@router.get("/open-trades")
def open_trades(
    category: str = Query(...),
    settleCoin: Optional[str] = Query(None),
    symbol: Optional[str] = Query(None)
):
    try:
        response = client.get_open_orders(category=category, settleCoin=settleCoin, symbol=symbol)
        return response
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
