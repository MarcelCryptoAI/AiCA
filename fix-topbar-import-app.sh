#!/bin/bash

echo "🛠️ Herstel TopBar import en integratie in App.jsx..."

APP_FILE="./frontend/src/App.jsx"

# Voeg de juiste import toe als die nog niet bestaat
if ! grep -q 'import TopBar from "./components/TopBar"' "$APP_FILE"; then
  sed -i '' '1a\
import TopBar from "./components/TopBar";
' "$APP_FILE"
  echo "✅ Import toegevoegd aan App.jsx"
else
  echo "ℹ️ Import bestaat al"
fi

# Voeg <TopBar /> direct boven <Router> in JSX toe als die er nog niet staat
if grep -q '<Router>' "$APP_FILE" && ! grep -q '<TopBar />' "$APP_FILE"; then
  sed -i '' '/<Router>/i\
      <TopBar />
' "$APP_FILE"
  echo "✅ <TopBar /> element toegevoegd boven <Router>"
else
  echo "ℹ️ TopBar bestaat al in JSX of <Router> niet gevonden"
fi

echo "✅ App.jsx klaar met correcte TopBar setup."
