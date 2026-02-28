# Gabagool Setup Index

**Repository:** [github.com/gabagool222/Gabagool](https://github.com/gabagool222/Gabagool)  
**Telegram:** [@gabagool222](https://t.me/gabagool222)

## Quick Navigation

| Document | Purpose |
|----------|---------|
| **[docs/getting-started.md](docs/getting-started.md)** | Full setup and how to run the bot (beginner-friendly) |
| **[docs/trading-strategy.md](docs/trading-strategy.md)** | How the bot trades, explained simply |
| **[QUICKSTART.md](QUICKSTART.md)** | Short quick start |
| **[README.md](README.md)** | Project overview, structure, and config |

## Project Structure

```
Gabagool/
├── bot/           # Trading bot (Python/FastAPI)
├── dashboard/     # Web UI (Next.js)
├── docs/          # Documentation
├── scripts/       # setup.sh, start-dev.sh
├── .env.example   # Copy to .env and configure
└── Makefile       # make help, make bot, make dashboard, make test
```

## Common Workflows

### First-time setup
1. Clone: `git clone https://github.com/gabagool222/Gabagool.git && cd Gabagool`
2. Env: `make setup` (or `cp .env.example .env`) then edit `.env`
3. Start Redis (locally)
4. Run bot: `./scripts/start-dev.sh` or `make bot`
5. Optional: `make dashboard` in another terminal

### Daily use
- Run bot: `make bot` or `cd bot && python -m src.main`
- Run dashboard: `make dashboard` or `cd dashboard && npm run dev`
- Tests: `make test` or `cd bot && pytest`

### Help
- Commands: `make help`
- Full guide: [docs/getting-started.md](docs/getting-started.md)
- Strategy: [docs/trading-strategy.md](docs/trading-strategy.md)
- Telegram: [@gabagool222](https://t.me/gabagool222)
