#!/bin/bash

echo "🚀 Wizard met popup + animatie wordt geïnstalleerd..."

COMPONENT_PATH="./src/pages/BrokerAccounts.jsx"
WIZARD_PATH="./src/components/AddBrokerWizard.jsx"
TAILWIND_CONFIG="./tailwind.config.js"

# ✅ BrokerAccounts pagina
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

      <h1 className="text-2xl font-bold mb-6">Broker Accounts</h1>
      {/* Accountlijst of andere inhoud */}

      {/* Modal overlay */}
      {showWizard && (
        <div className="fixed inset-0 bg-black bg-opacity-50 backdrop-blur-sm flex items-center justify-center z-50 animate-fadeIn">
          <div className="bg-white dark:bg-gray-900 rounded-xl shadow-xl w-full max-w-2xl p-8 relative">
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

# ✅ Wizard component met 2 stappen
cat > "$WIZARD_PATH" << 'EOF'
import React, { useState } from 'react';

export default function AddBrokerWizard({ onClose }) {
  const [step, setStep] = useState(1);
  const [selectedBrokers, setSelectedBrokers] = useState([]);
  const [name, setName] = useState('');
  const [apiKey, setApiKey] = useState('');
  const [apiSecret, setApiSecret] = useState('');

  const toggleBroker = (broker) => {
    setSelectedBrokers(prev =>
      prev.includes(broker) ? prev.filter(b => b !== broker) : [...prev, broker]
    );
  };

  const handleSubmit = () => {
    const account = {
      name,
      apiKey,
      apiSecret,
      brokers: selectedBrokers,
      status: "active",
    };
    const existing = JSON.parse(localStorage.getItem("brokerAccounts") || "[]");
    localStorage.setItem("brokerAccounts", JSON.stringify([...existing, account]));
    onClose();
  };

  return (
    <div>
      {step === 1 && (
        <div>
          <h2 className="text-xl font-semibold mb-4">Stap 1: Selecteer broker(s)</h2>
          <div className="space-y-2">
            <label className="flex items-center space-x-2">
              <input type="checkbox" checked={selectedBrokers.includes("Bybit Spot")} onChange={() => toggleBroker("Bybit Spot")} />
              <span>Bybit Spot</span>
            </label>
            <label className="flex items-center space-x-2">
              <input type="checkbox" checked={selectedBrokers.includes("Bybit Derivatives")} onChange={() => toggleBroker("Bybit Derivatives")} />
              <span>Bybit Derivatives</span>
            </label>
          </div>
          <div className="mt-6 flex justify-end">
            <button
              className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
              onClick={() => setStep(2)}
              disabled={selectedBrokers.length === 0}
            >
              Volgende
            </button>
          </div>
        </div>
      )}

      {step === 2 && (
        <div>
          <h2 className="text-xl font-semibold mb-4">Stap 2: Geef accountgegevens</h2>
          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium">Naam van het account</label>
              <input
                type="text"
                className="w-full px-3 py-2 border rounded bg-gray-100 dark:bg-gray-800"
                placeholder="Bijv. Bybit Derivatives"
                value={name}
                onChange={(e) => setName(e.target.value)}
              />
            </div>
            <div>
              <label className="block text-sm font-medium">API Key</label>
              <input
                type="text"
                className="w-full px-3 py-2 border rounded bg-gray-100 dark:bg-gray-800"
                value={apiKey}
                onChange={(e) => setApiKey(e.target.value)}
              />
            </div>
            <div>
              <label className="block text-sm font-medium">API Secret</label>
              <input
                type="password"
                className="w-full px-3 py-2 border rounded bg-gray-100 dark:bg-gray-800"
                value={apiSecret}
                onChange={(e) => setApiSecret(e.target.value)}
              />
            </div>
          </div>
          <div className="mt-6 flex justify-between">
            <button
              className="px-4 py-2 bg-gray-400 text-white rounded hover:bg-gray-500"
              onClick={() => setStep(1)}
            >
              Terug
            </button>
            <button
              className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700"
              onClick={handleSubmit}
              disabled={!name || !apiKey || !apiSecret}
            >
              Toevoegen
            </button>
          </div>
        </div>
      )}

      <div className="mt-6 text-right">
        <button
          className="text-sm text-gray-500 hover:text-red-500"
          onClick={onClose}
        >
          Annuleren
        </button>
      </div>
    </div>
  );
}
EOF

# ✅ Tailwind fadeIn animatie
if ! grep -q "fadeIn" "$TAILWIND_CONFIG"; then
  echo "🌀 Tailwind animatie fadeIn wordt toegevoegd..."
  sed -i '' '/extend: {/a\
      animation: {\n        fadeIn: "fadeIn 0.3s ease-out",\n      },\n      keyframes: {\n        fadeIn: {\n          "0%": { opacity: "0" },\n          "100%": { opacity: "1" }\n        }\n      },
' "$TAILWIND_CONFIG"
else
  echo "✅ fadeIn animatie al aanwezig in Tailwind config"
fi

echo "✅ Voltooid: wizard popup en broker selectie geïmplementeerd."
echo "💡 Herstart je dev server indien nodig: npm run dev"
