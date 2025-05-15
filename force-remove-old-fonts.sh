#!/bin/bash

echo "🚫 Verwijderen van alle sporen van Orbitron, Rajdhani, Audiowide, Anton in hele projectmap..."

# 1. Verwijder font links uit HTML bestanden
find . -name "*.html" -exec sed -i '' '/fonts.googleapis.com\/css2.*Orbitron/d' {} +
find . -name "*.html" -exec sed -i '' '/fonts.googleapis.com\/css2.*Rajdhani/d' {} +
find . -name "*.html" -exec sed -i '' '/fonts.googleapis.com\/css2.*Anton/d' {} +
find . -name "*.html" -exec sed -i '' '/fonts.googleapis.com\/css2.*Audiowide/d' {} +

# 2. Verwijder uit Tailwind config
find . -name "tailwind.config.js" -exec sed -i '' '/Orbitron/d' {} +
find . -name "tailwind.config.js" -exec sed -i '' '/Rajdhani/d' {} +
find . -name "tailwind.config.js" -exec sed -i '' '/Audiowide/d' {} +
find . -name "tailwind.config.js" -exec sed -i '' '/Anton/d' {} +

# 3. Verwijder uit CSS of andere JS/TS bestanden
find . -name "*.css" -exec sed -i '' '/Orbitron/d' {} +
find . -name "*.css" -exec sed -i '' '/Rajdhani/d' {} +
find . -name "*.css" -exec sed -i '' '/Anton/d' {} +
find . -name "*.css" -exec sed -i '' '/Audiowide/d' {} +

find . -name "*.js" -exec sed -i '' '/Orbitron/d' {} +
find . -name "*.js" -exec sed -i '' '/Rajdhani/d' {} +
find . -name "*.js" -exec sed -i '' '/Anton/d' {} +
find . -name "*.js" -exec sed -i '' '/Audiowide/d' {} +

find . -name "*.ts" -exec sed -i '' '/Orbitron/d' {} +
find . -name "*.ts" -exec sed -i '' '/Rajdhani/d' {} +
find . -name "*.ts" -exec sed -i '' '/Anton/d' {} +
find . -name "*.ts" -exec sed -i '' '/Audiowide/d' {} +

echo "✅ Alle oude fonts verwijderd. Voer nu eventueel opnieuw je Barlow-script uit en herstart: npm run dev"
