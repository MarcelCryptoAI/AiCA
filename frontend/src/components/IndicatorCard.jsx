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
