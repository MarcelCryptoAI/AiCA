#!/bin/bash

echo "🔧 BrokerAccounts.jsx + Wizard popup met fade-in wordt nu toegepast..."

# Pad naar je React project (pas aan indien nodig)
COMPONENT_PATH="./src/pages/BrokerAccounts.jsx"
WIZARD_PATH="./src/components/AddBrokerWizard.jsx"

# Vervang BrokerAccounts.jsx volledig
cat > "$COMPONENT_PATH" << 'EOF'
import React, { useState } from 'react';
import AddBrokerWizard from '../components/AddBrokerWizard';

export default function BrokerAccounts() {
  const [showWizard, setShowWizard] = useState(false);

  return (
    <div className="relative p-6">
      {/* Knop rechtsboven */}
      {!showWizard && (
        <button
          className="absolute top-4 right-6 bg-blue-600 text-white px-4 py-2 rounded-lg shadow hover:bg-blue-700 transition"
          onClick={() => setShowWizard(true)}
        >
          ➕ Account toevoegen
        </button>
      )}

      {/* Pagina inhoud */}
      <h1 className="text-2xl font-bold mb-6">Broker Accounts</h1>
      {/* Hier komt je account-tabel of component */}

      {/* Modal Overlay met fade-in */}
      {showWizard && (
        <div className="fixed inset-0 bg-black bg-opacity-50 backdrop-blur-sm flex items-center justify-center z-50 animate-fadeIn">
          <div className="bg-white dark:bg-gray-900 rounded-xl shadow-xl w-full max-w-2xl p-8 relative">
            {/* Sluitknop */}
            <button
              className="absolute top-4 right-4 text-gray-500 hover:text-red-500 text-2xl"
              onClick={() => setShowWizard(false)}
            >
              &times;
            </button>
            <AddBrokerWizard onClose={() => setShowWizard(false)} />
          </div>
        </div>
      )}
    </div>
  );
}
EOF

# Voeg CSS animatie toe aan Tailwind config (indien nog niet gedaan)
TAILWIND_CONFIG="./tailwind.config.js"
if ! grep -q "fadeIn" "$TAILWIND_CONFIG"; then
  echo "🌀 Toevoegen van fadeIn animatie aan Tailwind config..."
  sed -i '' '/extend: {/a\
      animation: {\n        fadeIn: "fadeIn 0.3s ease-out",\n      },\n      keyframes: {\n        fadeIn: {\n          "0%": { opacity: "0" },\n          "100%": { opacity: "1" }\n        }\n      },
' "$TAILWIND_CONFIG"
else
  echo "✅ fadeIn animatie al aanwezig in Tailwind config"
fi

# Vervang wizard component indien gewenst
cat > "$WIZARD_PATH" << 'EOF'
import React from 'react';

export default function AddBrokerWizard({ onClose }) {
  return (
    <div>
      <h2 className="text-xl font-semibold mb-4">Nieuw Brokeraccount toevoegen</h2>
      {/* Wizard stappen (mockup) */}
      <div className="space-y-4">
        <div>
          <label className="block text-sm font-medium">Broker Naam</label>
          <input type="text" className="w-full px-3 py-2 border rounded bg-gray-100 dark:bg-gray-800" placeholder="Bijv. Bybit Derivatives" />
        </div>
        <div>
          <label className="block text-sm font-medium">API Key</label>
          <input type="text" className="w-full px-3 py-2 border rounded bg-gray-100 dark:bg-gray-800" />
        </div>
        <div>
          <label className="block text-sm font-medium">Secret</label>
          <input type="password" className="w-full px-3 py-2 border rounded bg-gray-100 dark:bg-gray-800" />
        </div>
      </div>

      <div className="mt-6 flex justify-end space-x-4">
        <button
          className="px-4 py-2 bg-gray-500 text-white rounded hover:bg-gray-600"
          onClick={onClose}
        >
          Annuleren
        </button>
        <button
          className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
          onClick={onClose}
        >
          Toevoegen
        </button>
      </div>
    </div>
  );
}
EOF

echo "✅ BrokerAccounts pagina geüpdatet met wizard-popup en fade-in effect."
echo "📦 Vergeet niet Tailwind opnieuw te builden of te herstarten: npm run dev"
