#!/bin/bash

echo "🛠️ Voeg drag & drop containers toe aan bestaande TheAIAnalyzer.jsx..."

FRONTEND_DIR="./frontend"
PAGES_FILE="$FRONTEND_DIR/src/pages/TheAIAnalyzer.jsx"
COMPONENTS_DIR="$FRONTEND_DIR/src/components"

# 1. Controleer of pagina bestaat
if [ ! -f "$PAGES_FILE" ]; then
  echo "❌ Bestand TheAIAnalyzer.jsx niet gevonden! Stop."
  exit 1
fi

# 2. Voeg imports toe indien niet aanwezig
if ! grep -q "DropContainer" "$PAGES_FILE"; then
  sed -i '' "1a\
import DropContainer from '../components/DropContainer';\
import IndicatorCard from '../components/IndicatorCard';
" "$PAGES_FILE"
fi

# 3. Voeg de 3 containers onderaan toe (voor slot </div>)
awk '/<\/div>/{found=1} !found{{print}} /<\/div>/ && !added{{print containers; added=1}}' containers="$(cat <<EOF
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4 mt-12">
        <DropContainer
          title="🎯 Signaalbron"
          items={{signalSource}}
          setItems={{setSignalSource}}
          max={{1}}
        />
        <DropContainer
          title="✅ Actieve Bevestigers"
          items={{activeIndicators}}
          setItems={{setActiveIndicators}}
        />
        <DropContainer
          title="⛔ Inactief"
          items={{inactiveIndicators}}
          setItems={{setInactiveIndicators}}
          isInactive
        />
      </div>
EOF
)" "$PAGES_FILE" > "$PAGES_FILE.tmp" && mv "$PAGES_FILE.tmp" "$PAGES_FILE"

# 4. Voeg state variabelen toe net boven return
awk '/return *\(/{print "  const [signalSource, setSignalSource] = useState([]);";                     print "  const [activeIndicators, setActiveIndicators] = useState([]);";                     print "  const [inactiveIndicators, setInactiveIndicators] = useState([";                     print "    { id: \"RSI\", name: \"RSI\", winrate: 72, ibs: 65, manuallyDisabled: false },";                     print "    { id: \"EMA1\", name: \"EMA (5)\", winrate: 80, ibs: 85, manuallyDisabled: false },";                     print "    { id: \"EMA2\", name: \"EMA (20)\", winrate: 55, ibs: 60, manuallyDisabled: false },";                     print "    { id: \"WMA1\", name: \"WMA (10)\", winrate: 68, ibs: 50, manuallyDisabled: true },";                     print "    { id: \"VWMA1\", name: \"VWMA (10)\", winrate: 45, ibs: 30, manuallyDisabled: false }";                     print "  ]);"; next}1' "$PAGES_FILE" > "$PAGES_FILE.tmp" && mv "$PAGES_FILE.tmp" "$PAGES_FILE"

# 5. Components DropContainer.jsx en IndicatorCard.jsx aanmaken
mkdir -p "$COMPONENTS_DIR"

cat > "$COMPONENTS_DIR/DropContainer.jsx" <<'EOF'
import React from 'react';
import IndicatorCard from './IndicatorCard';

export default function DropContainer({ title, items, setItems, max = Infinity, isInactive = false }) {
  return (
    <div className="bg-gray-800 p-4 rounded shadow min-h-[200px]">
      <h2 className="text-cyan-400 font-semibold mb-2">{title}</h2>
      <div className="space-y-2">
        {items.map((item) => (
          <IndicatorCard key={item.id} data={item} isInactive={isInactive} />
        ))}
        {items.length === 0 && <p className="text-gray-500 text-sm">Sleep hier indicatoren naartoe</p>}
      </div>
    </div>
  );
}
EOF

cat > "$COMPONENTS_DIR/IndicatorCard.jsx" <<'EOF'
import React from 'react';
import clsx from 'clsx';

export default function IndicatorCard({ data, isInactive }) {
  const tooLow = data.winrate < 70 || data.ibs < 70;
  const autoDisabled = tooLow && !data.manuallyDisabled;

  return (
    <div className={clsx(
      "p-3 rounded bg-gray-700 relative border border-cyan-700",
      autoDisabled && "opacity-40 pointer-events-none"
    )}>
      <div className="font-bold">{data.name}</div>
      <div className="text-xs text-gray-300">
        Winrate: {data.winrate}%, IBS: {data.ibs}%
      </div>
      {autoDisabled && (
        <div className="absolute top-0 left-0 w-full h-full bg-black bg-opacity-40 flex items-center justify-center text-xs text-red-400">
          Niet geldig (lage score)
        </div>
      )}
    </div>
  );
}
EOF

echo "✅ Containers succesvol toegevoegd aan TheAIAnalyzer.jsx"
