# Gabagool - Quick Start Guide

**Repo:** [github.com/gabagool222/Gabagool](https://github.com/gabagool222/Gabagool) · **Telegram:** [@gabagool222](https://t.me/gabagool222)

For a full beginner guide, see **[docs/getting-started.md](docs/getting-started.md)**.

## 🚀 Quick Setup

### 1. Clone & env

```bash
git clone https://github.com/gabagool222/Gabagool.git
cd Gabagool
cp .env.example .env
# Edit .env: POLYMARKET_API_KEY, POLYMARKET_API_SECRET, PRIVATE_KEY
```

### 2. Start Redis

Start Redis locally (e.g. `redis-server` or your OS Redis service).

### 3. Run the bot

```bash
./scripts/start-dev.sh
# OR: cd bot && python -m venv venv && source venv/bin/activate && pip install -r requirements.txt && python -m src.main
```

### 4. (Optional) Run the dashboard

In another terminal:

```bash
cd dashboard
npm install
cp .env.local.example .env.local
npm run dev
```

- **Bot API / docs:** http://localhost:8000/docs  
- **Dashboard:** http://localhost:3000  

## 📋 Commands

```bash
make help       # List commands
make setup      # Create .env from template
make bot        # Run the bot
make dashboard  # Run the dashboard
make test       # Run bot tests
```

## 🎯 First-time checklist

- [ ] Python 3.11+ and Redis installed
- [ ] `.env` created and configured (API key, secret, PRIVATE_KEY)
- [ ] Redis running
- [ ] Bot starts and API responds at http://localhost:8000
- [ ] (Optional) Dashboard at http://localhost:3000

## 📚 Docs

- **[docs/getting-started.md](docs/getting-started.md)** — Full setup and usage (beginner-friendly)
- **[docs/trading-strategy.md](docs/trading-strategy.md)** — How the bot trades (explained simply)

**Support:** [@gabagool222](https://t.me/gabagool222)
