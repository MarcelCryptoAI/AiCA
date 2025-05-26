from fastapi import APIRouter, HTTPException, Body
from typing import Optional
from pybit.unified_trading import HTTP
import os

router = APIRouter(prefix="/api/bybit")

# Haal API keys uit environment
API_KEY = os.getenv("BYBIT_API_KEY")
API_SECRET = os.getenv("BYBIT_API_SECRET")

if not API_KEY or not API_SECRET:
    raise RuntimeError("BYBIT_API_KEY and BYBIT_API_SECRET must be set as environment variables")

# Maak een Bybit session object aan
session = HTTP(api_key=API_KEY, api_secret=API_SECRET)

@router.post("/open-trades")
async def open_trades(
    category: str = Body(..., embed=True),
    symbol: Optional[str] = Body(None, embed=True),
    baseCoin: Optional[str] = Body(None, embed=True),
    settleCoin: Optional[str] = Body(None, embed=True),
    openOnly: Optional[bool] = Body(True, embed=True),
    limit: Optional[int] = Body(50, embed=True)
):
    try:
        params = {
            "category": category,
            "openOnly": openOnly,
            "limit": limit
        }

        if symbol:
            params["symbol"] = symbol
        if baseCoin:
            params["baseCoin"] = baseCoin
        if settleCoin:
            params["settleCoin"] = settleCoin

        result = session.get_open_orders(**params)

        return result
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
