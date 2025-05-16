#!/bin/bash

echo "🔧 Herstel backend routerkoppeling voor bybit_trades"

cat > ./backend/src/main.py << 'EOF'
from fastapi import FastAPI
from routes.bybit_trades import router as bybit_router

app = FastAPI()

# ✅ Koppel de Bybit router
app.include_router(bybit_router)

@app.get("/")
def root():
    return {"status": "OK", "message": "Backend werkt"}
EOF

echo "✅ main.py is succesvol aangepast met router-import"
echo ""
echo "ℹ️ Start je backend opnieuw met:"
echo "cd backend"
echo "source venv/bin/activate"
echo "uvicorn main:app --reload --app-dir src"
