#!/bin/bash

echo "🔍 Start font cleanup vanaf projectroot..."

# 1. Zoek ongewenste fonts zoals Orbitron, Rajdhani, Anton, Audiowide
echo "🔎 Zoeken naar ongewenste fonts (Orbitron, Rajdhani, Audiowide, etc)..."
grep -riE 'Orbitron|Rajdhani|Anton|Audiowide' . || echo "✅ Geen ongewenste fonts gevonden in broncode."

# 2. Verwijder font-links uit alle HTML-bestanden behalve Barlow
echo "🧹 Verwijderen van ongewenste <link> tags in HTML-bestanden..."
find . -name "*.html" -exec sed -i '' '/fonts.googleapis.com\/css2.*Orbitron/d' {} +
find . -name "*.html" -exec sed -i '' '/fonts.googleapis.com\/css2.*Rajdhani/d' {} +
find . -name "*.html" -exec sed -i '' '/fonts.googleapis.com\/css2.*Anton/d' {} +
find . -name "*.html" -exec sed -i '' '/fonts.googleapis.com\/css2.*Audiowide/d' {} +

# 3. Voeg Barlow toe aan index.html indien nog niet aanwezig
if ! grep -q "fonts.googleapis.com/css2?family=Barlow" frontend/index.html; then
  sed -i '' '/<head>/a\
  <link href="https://fonts.googleapis.com/css2?family=Barlow:wght@300;400;600;700&display=swap" rel="stylesheet">
  ' frontend/index.html
  echo "✅ Google Font 'Barlow' toegevoegd aan frontend/index.html"
else
  echo "ℹ️ Barlow stond al in frontend/index.html"
fi

# 4. Corrigeer Tailwind config in frontend
if grep -q "fontFamily" frontend/tailwind.config.js; then
  echo "🧽 Opschonen van andere fonts uit tailwind.config.js..."
  sed -i '' '/fontFamily:/,/},/d' frontend/tailwind.config.js
fi

# 5. Voeg alleen Barlow toe aan Tailwind config
sed -i '' '/extend: {/a\
    fontFamily: {\n      sans: ["Barlow", "sans-serif"],\n    },
' frontend/tailwind.config.js
echo "✅ Alleen 'Barlow' actief in tailwind.config.js"

# 6. Controle tonen
echo ""
echo "📄 Actieve fonts in index.html:"
grep "fonts.googleapis.com" frontend/index.html

echo ""
echo "📄 Tailwind fontFamily sectie:"
grep "fontFamily" frontend/tailwind.config.js -A 5 || echo "⚠️ Geen fontFamily gevonden."

echo ""
echo "✅ Opschoning voltooid. Start nu je app opnieuw: npm run dev"
