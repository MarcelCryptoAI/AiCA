#!/bin/bash

echo "🔁 Herstellen van frontend stylingomgeving..."

cd frontend || { echo "❌ Map 'frontend' niet gevonden!"; exit 1; }

# Stap 1: Init Tailwind indien nodig
npx tailwindcss init -p

# Stap 2: Schrijf standaard tailwind.config.js
cat > tailwind.config.js <<EOF
module.exports = {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {},
  },
  plugins: [],
};
EOF

# Stap 3: Schrijf postcss.config.js
cat > postcss.config.js <<EOF
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  },
}
EOF

# Stap 4: Herstel index.css
mkdir -p src && cat > src/index.css <<EOF
@tailwind base;
@tailwind components;
@tailwind utilities;
EOF

# Stap 5: Controleer of index.css wordt geïmporteerd in main.jsx
MAIN_FILE="src/main.jsx"
if ! grep -q "import './index.css'" "$MAIN_FILE"; then
  echo "import './index.css'" | cat - "$MAIN_FILE" > temp && mv temp "$MAIN_FILE"
  echo "✅ index.css import toegevoegd aan main.jsx"
else
  echo "✅ index.css wordt al geïmporteerd"
fi

echo "✅ Tailwind UI herstel voltooid"
