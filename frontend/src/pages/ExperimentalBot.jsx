import React from 'react';

export default function ExperimentalBot() {
  return (
    <div className="p-6 text-white space-y-6">
      <h1 className="text-3xl font-bold">Experimental Bot</h1>
      
      <div className="bg-gray-800 p-6 rounded shadow space-y-4">
        <h2 className="text-xl font-semibold text-cyan-400">🧪 Test Environment</h2>
        <p className="text-gray-300">
          Deze pagina is in ontwikkeling. Hier komt de experimentele bot functionaliteit.
        </p>
        
        <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-6">
          <div className="bg-gray-700 p-4 rounded">
            <h3 className="text-lg font-semibold text-cyan-200 mb-2">Bot Status</h3>
            <p className="text-gray-400">Nog niet actief</p>
          </div>
          
          <div className="bg-gray-700 p-4 rounded">
            <h3 className="text-lg font-semibold text-cyan-200 mb-2">Test Data</h3>
            <p className="text-gray-400">Geen data beschikbaar</p>
          </div>
        </div>
        
        <div className="mt-6">
          <button className="bg-cyan-600 hover:bg-cyan-700 px-4 py-2 rounded mr-2">
            Start Test
          </button>
          <button className="bg-gray-600 hover:bg-gray-700 px-4 py-2 rounded">
            Configuratie
          </button>
        </div>
      </div>
    </div>
  );
}
