#!/bin/bash

echo "➕ Voeg een globale topbar toe met OpenAI-creditsaldo..."

FRONTEND_DIR="./frontend"
COMPONENTS_DIR="$FRONTEND_DIR/src/components"
LAYOUT_FILE="$FRONTEND_DIR/src/App.jsx"

mkdir -p "$COMPONENTS_DIR"

# 1. Topbar component aanmaken
cat > "$COMPONENTS_DIR/TopBar.jsx" <<'EOF'
import React, { useEffect, useState } from 'react';

export default function TopBar() {
  const [credits, setCredits] = useState(null);

  useEffect(() => {
    const stored = localStorage.getItem('openaiCredits');
    if (stored) setCredits(stored);
  }, []);

  return (
    <div className="w-full bg-gray-900 border-b border-gray-700 text-right text-sm px-4 py-2 text-white">
      <span className="text-gray-400">OpenAI Credits:</span>
      <span className="ml-2 text-green-400">${credits ?? '...'}</span>
    </div>
  );
}
EOF

# 2. App.jsx aanpassen om TopBar bovenaan toe te voegen
if grep -q "<Router>" "$LAYOUT_FILE"; then
  sed -i '' '/<Router>/a\
      <TopBar />
' "$LAYOUT_FILE"

  if ! grep -q "TopBar" "$LAYOUT_FILE"; then
    sed -i '' '1a\
import TopBar from "./components/TopBar";
' "$LAYOUT_FILE"
  fi
else
  echo "❌ App.jsx heeft geen <Router> tag — voeg handmatig TopBar toe."
fi

echo "✅ Topbar toegevoegd in TopBar.jsx en ingevoegd in App.jsx."
