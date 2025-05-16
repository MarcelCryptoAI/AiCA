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
