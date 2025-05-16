#!/bin/bash

echo "🚀 Start frontend en backend in aparte macOS vensters..."

# Pad bepalen
PROJECT_DIR="$(cd "$(dirname "$0")"; pwd)"

# Backend starten in Terminal
osascript <<END
tell application "Terminal"
    do script "cd \"$PROJECT_DIR/backend\"; source venv/bin/activate; uvicorn main:app --reload --app-dir src"
end tell
END

# Frontend starten in nieuwe Terminal
osascript <<END
tell application "Terminal"
    do script "cd \"$PROJECT_DIR/frontend\"; npm run dev"
end tell
END
