from pathlib import Path

# Shell script dat enkel de "Account toevoegen" knop toevoegt aan BrokerAccounts.jsx
script_content = """#!/bin/bash

echo "🔧 Voeg '➕ Account toevoegen' knop toe aan bestaande BrokerAccounts.jsx..."

TARGET="./src/pages/BrokerAccounts.jsx"

# Voeg button toe vlak voor <h1> element
sed -i '' '/<h1 className="text-3xl font-bold">Broker Accounts<\\/h1>/i\\
{!showWizard && (\\
  <button\\
    className="absolute top-4 right-6 bg-blue-600 text-white px-4 py-2 rounded-lg shadow hover:bg-blue-700 transition"\\
    onClick={() => setShowWizard(true)}\\
  >\\
    ➕ Account toevoegen\\
  </button>\\
)}\\
' "$TARGET"

# Zorg dat de buitenste container div className 'relative' heeft
sed -i '' 's/className="p-6 /className="relative p-6 /' "$TARGET"

echo "✅ Knop toegevoegd. Start je dev server opnieuw met: npm run dev"
"""

output_path = "/mnt/data/add-account-button.sh"
Path(output_path).write_text(script_content)
output_path
