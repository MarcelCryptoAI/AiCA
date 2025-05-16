from fastapi import FastAPI
from routes.bybit_trades import router as bybit_router

app = FastAPI()

# ✅ Koppel de Bybit router
app.include_router(bybit_router)

@app.get("/")
def root():
    return {"status": "OK", "message": "Backend werkt"}
