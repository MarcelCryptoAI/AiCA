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
