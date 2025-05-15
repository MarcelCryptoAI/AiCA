import React from 'react';
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import Layout from './layout/Layout';
import { routes } from './config/routesConfig';

import Dashboard from './pages/Dashboard';
import Trades from './pages/Trades';
import OpenTrades from './pages/OpenTrades';
import Signals from './pages/Signals';
import Accounts from './pages/Accounts';
import TradingAI from './pages/TradingAI';

const components: { [key: string]: React.ComponentType } = {
  Dashboard,
  Trades,
  OpenTrades,
  Signals,
  Accounts,
  TradingAI,
};

export default function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Layout />}>
          {routes.map(({ path, title }) => {
            const key = title.replace(/\s/g, '');
            const Component = components[key];
            return <Route key={path} path={path} element={<Component />} />;
          })}
          <Route path="*" element={<div className="text-red-500 p-6 text-xl">404 - Pagina niet gevonden</div>} />
        </Route>
      </Routes>
    </Router>
  );
}
