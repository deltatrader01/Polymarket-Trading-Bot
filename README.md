# 🍖 Gabagool - Polymarket Volatility Arbitrage Bot

**Gabagool** is an automated volatility arbitrage trading bot for Polymarket that exploits pricing inefficiencies in prediction markets. The bot monitors market volatility, identifies arbitrage opportunities, and executes delta-neutral trades to capture spread profits while managing risk.

**Repository:** [https://github.com/deltatrader01/Polymarket-Trading-Bot](https://github.com/deltatrader01/Polymarket-Trading-Bot)  
**Telegram:** [@gabagool222](https://t.me/gabagool222)

---

## 📁 Project Structure

```
Gabagool/
├── bot/           # Trading bot (Python/FastAPI) — Polymarket API, strategy, risk engine
├── dashboard/     # Web UI (Next.js) — monitor positions and control the bot
├── docs/          # Documentation — how to use the bot and strategy explained
├── scripts/      # Setup and development scripts
├── .env.example  # Environment template (copy to .env and configure)
└── README.md      # This file
```

- **New to the bot?** Start with **[docs/getting-started.md](docs/getting-started.md)** (install and run).
- **Want to understand the strategy?** Read **[docs/trading-strategy.md](docs/trading-strategy.md)** (beginner-friendly).

---

## 🎯 Strategy Overview

- **Volatility arbitrage** — Trades when YES + NO cost less than $1 (mispricing).
- **Delta-neutral** — Keeps exposure balanced so profit doesn’t depend on the outcome.
- **Risk controls** — Position limits, delta limits, settlement buffer, stop-loss.

See **[docs/trading-strategy.md](docs/trading-strategy.md)** for a simple, full explanation.

---

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                      Gabagool System                         │
├─────────────────────────────────────────────────────────────┤
│  ┌──────────────┐      ┌──────────────┐      ┌──────────┐   │
│  │   Next.js    │      │   FastAPI    │      │  Redis   │   │
│  │  Dashboard   │◄────►│     Bot      │◄────►│  Cache   │   │
│  │  (Port 3000) │      │  (Port 8000) │      │ (6379)   │   │
│  └──────────────┘      └──────────────┘      └──────────┘   │
│         │                     │                              │
│         │                     ▼                             │
│         │              ┌──────────────┐                      │
│         │              │  Polymarket  │                      │
│         │              │   CLOB API   │                      │
│         └──────────────┴──────────────┘                      │
└─────────────────────────────────────────────────────────────┘
```

---

## 📋 Prerequisites

- **Python** 3.11+ (bot)
- **Node.js** 20+ (dashboard, optional)
- **Redis** (bot state)
- **Polymarket** API credentials
- **Polygon** wallet with USDC and some MATIC for gas
- **Capital:** ~$500–1,000+ USDC recommended

---

## 🚀 Quick Start

### 1. Clone

```bash
git clone https://github.com/gabagool222/Gabagool.git
cd Gabagool
```

### 2. Configure

```bash
cp .env.example .env
# Edit .env: POLYMARKET_API_KEY, POLYMARKET_API_SECRET, PRIVATE_KEY
```

### 3. Run Redis

Start Redis locally (e.g. `redis-server`, or your OS service). The bot needs it for state.

### 4. Run the Bot

```bash
cd bot
python -m venv venv
# Windows: venv\Scripts\activate
# macOS/Linux: source venv/bin/activate
pip install -r requirements.txt
python -m src.main
```

Bot API: **http://localhost:8000** — API docs: **http://localhost:8000/docs**

### 5. (Optional) Run the Dashboard

In a new terminal:

```bash
cd dashboard
npm install
cp .env.local.example .env.local
# Set NEXT_PUBLIC_API_URL=http://localhost:8000 if needed
npm run dev
```

Dashboard: **http://localhost:3000**

**Full step-by-step guide:** [docs/getting-started.md](docs/getting-started.md)

---

## ⚙️ Configuration

Key variables in `.env` (see `.env.example`):

| Parameter | Default | Description |
|-----------|---------|-------------|
| `MAX_UNHEDGED_DELTA` | 100 | Max unhedged position (USDC) |
| `PROFIT_MARGIN` | 0.02 | Min profit margin (2%) |
| `SETTLEMENT_BUFFER_SECONDS` | 300 | Don’t trade near settlement |
| `MAX_POSITION_SIZE` | 1000 | Max size per position (USDC) |

Advanced options are in `bot/src/config.py`.

---

## 🎮 Makefile (Local Dev)

```bash
make help      # List commands
make bot       # Run the bot (from bot/ with venv)
make dashboard # Run the dashboard (from dashboard/)
make test      # Run bot tests (from bot/)
```

(Redis must be running separately.)

---

## 🧪 Testing

```bash
cd bot
pip install -r requirements.txt
pytest
```

---

## ⚠️ Risk Warnings

Trading involves risk of loss. Possible risks include: smart contract risk, market and liquidity risk, execution slippage, oracle/settlement issues, gas costs. Only use funds you can afford to lose. This software is provided “as is.”

---

## 📞 Support

- **Docs:** [docs/](docs/) — [Getting Started](docs/getting-started.md), [Trading Strategy](docs/trading-strategy.md)
- **Telegram:** [@gabagool222](https://t.me/gabagool222)
- **API docs (when bot running):** http://localhost:8000/docs

---

**Disclaimer:** This software is for educational use. Trading involves substantial risk. Use at your own risk.
