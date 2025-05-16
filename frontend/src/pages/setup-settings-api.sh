#!/bin/bash

echo "⚙️ Setup van Settings-pagina met Bybit en OpenAI API-integratie UI..."

FRONTEND_DIR="./frontend"
PAGES_DIR="$FRONTEND_DIR/src/pages"
mkdir -p "$PAGES_DIR"

cat > "$PAGES_DIR/Settings.jsx" <<'EOF'
import React, { useState, useEffect } from 'react';

export default function Settings() {
  const [bybitKey, setBybitKey] = useState('');
  const [openaiKey, setOpenaiKey] = useState('');
  const [credits, setCredits] = useState(null);
  const [modelExplain, setModelExplain] = useState('gpt-4');
  const [modelAdvice, setModelAdvice] = useState('gpt-4');

  useEffect(() => {
    if (openaiKey) {
      setCredits('123.45');
    }
  }, [openaiKey]);

  return (
    <div className="p-6 text-white space-y-8">
      <h1 className="text-3xl font-bold mb-6">Instellingen</h1>

      <div className="bg-gray-800 rounded p-4 shadow space-y-2">
        <h2 className="text-xl font-semibold text-cyan-400">🔑 Bybit API Key</h2>
        {bybitKey ? (
          <input
            value={bybitKey}
            onChange={e => setBybitKey(e.target.value)}
            className="bg-gray-700 w-full p-2 rounded"
            placeholder="Voer je Bybit API key in"
          />
        ) : (
          <a
            href="https://www.bybit.com/app/user/api-management"
            target="_blank"
            rel="noopener noreferrer"
            className="inline-block bg-cyan-600 hover:bg-cyan-700 text-white px-4 py-2 rounded"
          >
            Connect met Bybit
          </a>
        )}
      </div>

      <div className="bg-gray-800 rounded p-4 shadow space-y-2">
        <h2 className="text-xl font-semibold text-cyan-400">🧠 OpenAI API Key</h2>
        {openaiKey ? (
          <>
            <input
              value={openaiKey}
              onChange={e => setOpenaiKey(e.target.value)}
              className="bg-gray-700 w-full p-2 rounded"
              placeholder="Voer je OpenAI key in"
            />
            <p className="text-sm text-gray-400 mt-1">Huidige credits: <span className="text-green-400">{credits ?? 'laden...'}</span></p>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-4">
              <div>
                <label className="block mb-1 text-sm">Model voor uitleg op indicatorkaart:</label>
                <select value={modelExplain} onChange={e => setModelExplain(e.target.value)} className="bg-gray-700 w-full p-2 rounded">
                  <option value="gpt-3.5-turbo">gpt-3.5-turbo</option>
                  <option value="gpt-4">gpt-4</option>
                  <option value="gpt-4o">gpt-4o</option>
                </select>
              </div>
              <div>
                <label className="block mb-1 text-sm">Model voor AI-advies & strategieën:</label>
                <select value={modelAdvice} onChange={e => setModelAdvice(e.target.value)} className="bg-gray-700 w-full p-2 rounded">
                  <option value="gpt-3.5-turbo">gpt-3.5-turbo</option>
                  <option value="gpt-4">gpt-4</option>
                  <option value="gpt-4o">gpt-4o</option>
                </select>
              </div>
            </div>
          </>
        ) : (
          <a
            href="https://platform.openai.com/api-keys"
            target="_blank"
            rel="noopener noreferrer"
            className="inline-block bg-cyan-600 hover:bg-cyan-700 text-white px-4 py-2 rounded"
          >
            Connect met OpenAI
          </a>
        )}
      </div>
    </div>
  );
}
EOF

echo "✅ Settings-pagina succesvol aangemaakt: frontend/src/pages/Settings.jsx"
