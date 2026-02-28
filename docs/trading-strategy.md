# Gabagool Trading Strategy Explained

This document explains **how the Gabagool bot trades** in plain language, so you can understand what it does before you run it.

---

## What Is Volatility Arbitrage?

Prediction markets (like Polymarket) ask “Will X happen?” and trade **YES** and **NO** shares. In theory, the price of YES + the price of NO should equal about **$1** (100 cents), because one of them will pay $1 at settlement.

In practice, prices move a lot and sometimes **YES + NO** is less than $1. When that happens, you can buy both sides for less than $1 and lock in a profit when the market settles. That’s the core idea behind **volatility arbitrage**: profit from temporary mispricings, especially when there’s a lot of volatility.

---

## What the Bot Actually Does

The bot does three main things:

1. **Scans markets** — It watches Polymarket order books and looks for markets where buying both YES and NO costs less than $1 (after fees and slippage).
2. **Keeps positions balanced (delta-neutral)** — It tries to keep equal exposure on YES and NO so that, regardless of the outcome, the combined position is profitable. If one side gets too large, it “rebalances” by buying the other side.
3. **Manages risk** — It limits position size, avoids markets that are about to settle, and can stop trading or close out if something goes wrong.

So in one sentence: **the bot looks for mispriced YES/NO pairs, buys both sides when it’s profitable, and keeps the position balanced so the result is roughly outcome-independent.**

---

## Main Ideas (Simplified)

### 1. The “Arbitrage” Condition

The bot is looking for situations like:

- **Buy YES** at price A and **Buy NO** at price B.
- If **A + B < 1** (after fees), there’s a theoretical profit: you pay A + B now and get $1 at settlement.

The bot only trades when:

- That profit margin is above a minimum (e.g. 2%) **and**
- There’s enough liquidity (order book depth) to get filled **and**
- Your current exposure (delta) stays within limits.

### 2. Delta-Neutral Hedging

“Delta” here means: how much you profit if the outcome is YES vs NO.

- **Delta-neutral** = your PnL doesn’t depend much on whether YES or NO wins. You make money from the spread (buying below $1), not from betting on the outcome.

The bot:

- Tracks how much you have on YES vs NO.
- If you’re too heavy on one side (delta too high or too low), it buys the other side to rebalance.
- That keeps the position roughly neutral so you’re not “betting” on the result.

### 3. Risk Controls (What the Bot Won’t Do)

To avoid big losses, the bot:

- **Limits position size** — Won’t put too much in a single market or in total.
- **Limits “delta”** — Won’t let unhedged exposure get too large.
- **Avoids settlement** — Stops adding to positions when the market is close to settling (e.g. last few minutes).
- **Can stop or exit** — Has safeguards (e.g. stop-loss, halt flag) to pause or close if something goes wrong.

You can tune these in config (see main README and `.env`).

---

## Flow of a Typical Trade

1. **Scan** — Bot checks order books for markets where Ask(YES) + Ask(NO) &lt; 1 (minus fees).
2. **Check** — It verifies liquidity, delta limits, settlement time, and min profit margin.
3. **Enter** — It places limit orders to buy YES and/or NO to open or add to a delta-neutral position.
4. **Monitor** — While the position is open, it keeps checking delta and liquidity.
5. **Rebalance** — If delta moves away from zero, it buys the other side to bring it back.
6. **Exit** — When the market settles, you receive $1 per share on the winning side; the combined cost was &lt; $1, so you keep the difference as profit (minus fees and gas).

---

## Key Terms (Glossary)

| Term | Meaning |
|------|--------|
| **Order book** | List of buy/sell orders (bids and asks) at different prices. |
| **Bid** | Price someone is willing to buy at. **Ask** = price someone is willing to sell at. |
| **Spread** | Difference between best ask and best bid. Tighter spread = cheaper to trade. |
| **Delta** | How much your PnL changes if YES wins vs NO wins. Zero delta = neutral. |
| **Liquidity** | Enough size in the order book so you can get filled without moving the price too much. |
| **Settlement** | When the market resolves and YES or NO pays $1 per share. |
| **Rebalancing** | Buying the opposite side (YES or NO) to bring delta back toward zero. |

---

## What Can Go Wrong? (Risks)

Even with arbitrage, you can lose money. Examples:

- **Liquidity dries up** — You can’t rebalance or exit at a good price.
- **Slippage** — You get filled at worse prices than the order book suggested.
- **Fees and gas** — Transaction and gas costs eat into the edge.
- **Settlement/oracle issues** — Delays or errors in resolution.
- **Smart contract risk** — Bugs or exploits in Polymarket contracts.

The bot’s risk controls are there to reduce these, but they can’t remove them. Only risk capital you can afford to lose.

---

## How This Fits in the Code

- **Scanner / opportunity detection** — Finds markets and prices where the arbitrage condition holds.
- **Accumulator** — Decides when to enter and how much to buy (YES/NO) to stay within delta limits.
- **Equalizer** — Handles rebalancing (buying the lagging side to keep delta neutral).
- **Risk engine** — Enforces max delta, liquidity checks, settlement buffer, and emergency exit/halt.

For file locations and more technical detail, see the main [README](../README.md) and the `bot/` folder.

---

## Summary

- Gabagool is a **volatility arbitrage** bot: it buys YES and NO when their combined cost is less than $1 and aims to be **delta-neutral**.
- It **scans** order books, **enters** when the edge is big enough, **rebalances** to stay neutral, and **exits** at settlement to capture the spread.
- Risk controls limit size, delta, and exposure to markets near settlement.

For setup and running the bot, see **[Getting Started](getting-started.md)**.  
For support or questions: **Telegram [@gabagool222](https://t.me/gabagool222)**.

**Disclaimer:** This is an explanation of the strategy, not financial or legal advice. Trading involves risk of loss. Use the bot at your own risk.
