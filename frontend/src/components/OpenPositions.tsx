import React, { useEffect, useState } from 'react'

interface Position {
  symbol: string
  side: string
  size: string
  entryPrice: string
  positionValue: string
  leverage: string
}

export default function OpenPositions() {
  const [positions, setPositions] = useState<Position[]>([])
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    const fetchPositions = async () => {
      try {
        const res = await fetch('http://localhost:8000/api/bybit/positions?category=linear')
        const data = await res.json()
        setPositions(data.result?.list || [])
      } catch (err) {
        console.error("Failed to load positions", err)
      } finally {
        setLoading(false)
      }
    }

    fetchPositions()
  }, [])

  return (
    <div className="mt-10">
      <h2 className="text-xl font-bold mb-2 text-white">Open Positions (Linear)</h2>
      {loading ? (
        <p className="text-gray-400">Loading positions...</p>
      ) : positions.length === 0 ? (
        <p className="text-gray-400">No open positions found.</p>
      ) : (
        <table className="min-w-full text-sm text-left border border-gray-600 text-white">
          <thead className="bg-gray-800">
            <tr>
              <th className="px-4 py-2 border">Symbol</th>
              <th className="px-4 py-2 border">Side</th>
              <th className="px-4 py-2 border">Size</th>
              <th className="px-4 py-2 border">Entry Price</th>
              <th className="px-4 py-2 border">Position Value</th>
              <th className="px-4 py-2 border">Leverage</th>
            </tr>
          </thead>
          <tbody>
            {positions.map((pos, idx) => (
              <tr key={idx} className="border-t border-gray-700">
                <td className="px-4 py-2">{pos.symbol}</td>
                <td className="px-4 py-2">{pos.side}</td>
                <td className="px-4 py-2">{pos.size}</td>
                <td className="px-4 py-2">{pos.entryPrice}</td>
                <td className="px-4 py-2">{pos.positionValue}</td>
                <td className="px-4 py-2">{pos.leverage}</td>
              </tr>
            ))}
          </tbody>
        </table>
      )}
    </div>
  )
}
