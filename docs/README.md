# Gabagool Documentation

Documentation for **Gabagool** — a Polymarket volatility arbitrage trading bot.

## Documentation Index

| Document | Description |
|----------|-------------|
| **[Getting Started](getting-started.md)** | How to install, configure, and run the bot (beginner-friendly). |
| **[Trading Strategy](trading-strategy.md)** | How the bot works and what it trades (explained simply). |

## Quick Links

- **Repository**: [github.com/gabagool222/Gabagool](https://github.com/gabagool222/Gabagool)
- **Telegram**: [@gabagool222](https://t.me/gabagool222)
- **API Docs** (when bot is running): `http://localhost:8000/docs`
- **Dashboard** (when running): `http://localhost:3000`

## Project Structure

```
Gabagool/
├── bot/           # Trading bot (Python) — connects to Polymarket, runs strategy
├── dashboard/     # Web UI (Next.js) — monitor positions and control the bot
├── docs/           # Documentation (this folder)
├── scripts/        # Setup and dev scripts
└── .env.example    # Environment template — copy to .env and fill in
```

Start with **[Getting Started](getting-started.md)** if you are new.
