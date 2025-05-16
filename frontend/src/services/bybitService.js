export async function fetchOpenTrades(apiKey, apiSecret) {
  const res = await fetch("/api/bybit/open-trades", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ apiKey, apiSecret })
  });
  return await res.json();
}

export async function fetchClosedTrades(apiKey, apiSecret) {
  const res = await fetch("/api/bybit/closed-trades", {
    method: "POST",
    headers: { "Content-Type": "application/json" },
    body: JSON.stringify({ apiKey, apiSecret })
  });
  return await res.json();
}
