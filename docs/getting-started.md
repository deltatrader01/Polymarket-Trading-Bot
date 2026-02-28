# Getting Started with Gabagool

This guide walks you through installing, configuring, and running the Gabagool bot step by step. No prior bot or Polymarket experience required.

---

## What You Need Before Starting

- **A computer** with Windows, macOS, or Linux
- **Python 3.11+** (for the bot)
- **Node.js 20+** (for the dashboard; optional if you only run the bot)
- **Redis** (for the bot’s state; can run locally or in the cloud)
- **Polymarket account** with API keys
- **Polygon wallet** with some USDC and a little MATIC for gas
- **At least ~$500–1,000 USDC** recommended to run the strategy safely

---

## Step 1: Get the Code

Clone the repository:

```bash
git clone https://github.com/gabagool222/Gabagool.git
cd Gabagool
```

---

## Step 2: Install Redis

The bot uses Redis to store positions and state.

- **Windows**: Install [Redis for Windows](https://github.com/microsoftarchive/redis/releases) or use WSL and install Redis there.
- **macOS**: `brew install redis` then `brew services start redis`
- **Linux**: `sudo apt install redis-server` (or your distro’s package) and start the `redis` service

Check that Redis is running:

```bash
redis-cli ping
```

You should see `PONG`.

---

## Step 3: Configure the Bot

1. Copy the environment template:

   ```bash
   cp .env.example .env
   ```

2. Open `.env` in a text editor and fill in:

   | Variable | Where to get it |
   |----------|------------------|
   | `POLYMARKET_API_KEY` | Polymarket → Settings → API |
   | `POLYMARKET_API_SECRET` | Same place |
   | `POLYMARKET_API_PASSPHRASE` | Same place (if required) |
   | `PRIVATE_KEY` | Your Polygon wallet private key (e.g. MetaMask export; **keep this secret**) |

3. Optionally adjust risk and behavior (see **Step 5** and the main [README](../README.md)).

**Important:** Never commit `.env` or share your `PRIVATE_KEY` or API secret.

---

## Step 4: Run the Bot

1. Go into the bot folder and install dependencies:

   ```bash
   cd bot
   python -m venv venv
   # Windows:
   venv\Scripts\activate
   # macOS/Linux:
   source venv/bin/activate
   pip install -r requirements.txt
   ```

2. Make sure `.env` is in the **project root** (the `Gabagool` folder), not only in `bot/`. The bot will load it from the project root when you run from there, or you can copy `.env` into `bot/` and run from `bot/`.

3. Start the bot:

   ```bash
   # From bot/ with venv active:
   python -m src.main
   ```

   Or from the project root:

   ```bash
   cd bot
   python -m src.main
   ```

You should see logs indicating the bot is connected and (if configured) scanning markets. The bot API is at **http://localhost:8000**. Open **http://localhost:8000/docs** for the API documentation.

---

## Step 5: (Optional) Run the Dashboard

The dashboard is a web UI to monitor positions and control the bot.

1. Open a **new** terminal. From the project root:

   ```bash
   cd dashboard
   npm install
   cp .env.local.example .env.local
   ```

2. In `.env.local`, set the bot API URL (if different):

   ```
   NEXT_PUBLIC_API_URL=http://localhost:8000
   ```

3. Start the dashboard:

   ```bash
   npm run dev
   ```

4. Open **http://localhost:3000** in your browser.

---

## Step 6: Understand What the Bot Is Doing

- Read **[Trading Strategy](trading-strategy.md)** for a simple explanation of how the bot trades.
- Use the dashboard to watch position, PnL, and controls.
- Use **http://localhost:8000/docs** to see status, trades, and order book endpoints.

---

## Common Issues

| Problem | What to do |
|--------|------------|
| “Redis connection refused” | Start Redis (see Step 2) and ensure nothing else is blocking the Redis port. |
| “.env not found” | Ensure `.env` exists in the project root or in `bot/`, and that you’re running the bot from the correct directory. |
| “Invalid API key” | Double-check Polymarket API key/secret/passphrase and that the key is enabled. |
| “Insufficient balance” | Add USDC (and a little MATIC for gas) to the wallet whose `PRIVATE_KEY` is in `.env`. |
| Dashboard “Cannot connect” | Ensure the bot is running on port 8000 and `NEXT_PUBLIC_API_URL` in dashboard `.env.local` is `http://localhost:8000`. |

---

## Next Steps

- **[Trading Strategy](trading-strategy.md)** — how the bot finds and executes trades  
- **Main [README](../README.md)** — architecture, risk settings, and advanced options  
- **Telegram:** [@gabagool222](https://t.me/gabagool222) for questions or support

**Disclaimer:** Trading involves risk of loss. Only use funds you can afford to lose. This bot is provided as-is; you are responsible for your own trading decisions.
