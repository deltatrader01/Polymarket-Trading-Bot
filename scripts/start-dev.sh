#!/bin/bash

# Gabagool Development Startup Script (local, no Docker)
# Checks prerequisites and starts the bot; run dashboard in a separate terminal.

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

PROJECT_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$PROJECT_ROOT"

echo -e "${BLUE}"
echo "╔════════════════════════════════════════════════════════════╗"
echo "║          🍖 Gabagool - Development Startup                 ║"
echo "║     Polymarket Volatility Arbitrage Bot                   ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo -e "${NC}"

check_python() {
    echo -e "${BLUE}[1/4] Checking Python...${NC}"
    if ! command -v python3 &> /dev/null && ! command -v python &> /dev/null; then
        echo -e "${RED}❌ Python not found. Install Python 3.11+${NC}"
        exit 1
    fi
    echo -e "${GREEN}✓ Python found${NC}"
}

check_redis() {
    echo -e "${BLUE}[2/4] Checking Redis...${NC}"
    if ! command -v redis-cli &> /dev/null; then
        echo -e "${YELLOW}⚠️  redis-cli not found. Install Redis and ensure it's running.${NC}"
    elif ! redis-cli ping &> /dev/null; then
        echo -e "${RED}❌ Redis is not running. Start Redis (e.g. redis-server) and try again.${NC}"
        exit 1
    else
        echo -e "${GREEN}✓ Redis is running${NC}"
    fi
}

check_env_file() {
    echo -e "${BLUE}[3/4] Checking .env...${NC}"
    if [ ! -f "$PROJECT_ROOT/.env" ]; then
        if [ -f "$PROJECT_ROOT/.env.example" ]; then
            cp "$PROJECT_ROOT/.env.example" "$PROJECT_ROOT/.env"
            echo -e "${GREEN}✓ Created .env from .env.example${NC}"
            echo -e "${YELLOW}⚠️  Edit .env with your Polymarket API key, secret, and PRIVATE_KEY before trading.${NC}"
        else
            echo -e "${RED}❌ .env.example not found${NC}"
            exit 1
        fi
    else
        echo -e "${GREEN}✓ .env exists${NC}"
        if grep -q "your_api_key_here" "$PROJECT_ROOT/.env" 2>/dev/null; then
            echo -e "${YELLOW}⚠️  .env has placeholder values. Edit with real credentials.${NC}"
        fi
    fi
}

install_bot_deps() {
    echo -e "${BLUE}[4/4] Bot dependencies...${NC}"
    if [ ! -d "$PROJECT_ROOT/bot/venv" ]; then
        echo -e "${BLUE}Creating venv in bot/...${NC}"
        (cd "$PROJECT_ROOT/bot" && python3 -m venv venv 2>/dev/null || python -m venv venv)
    fi
    (cd "$PROJECT_ROOT/bot" && ./venv/bin/pip install -q -r requirements.txt 2>/dev/null || venv/Scripts/pip install -q -r requirements.txt 2>/dev/null || pip install -q -r requirements.txt)
    echo -e "${GREEN}✓ Bot dependencies ready${NC}"
}

main() {
    check_python
    check_redis
    check_env_file
    install_bot_deps

    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                  Starting Gabagool bot                     ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "${BLUE}Bot API:${NC}    http://localhost:8000"
    echo -e "${BLUE}API docs:${NC}   http://localhost:8000/docs"
    echo ""
    echo -e "${YELLOW}To run the dashboard, open another terminal and run:${NC}"
    echo -e "  ${BLUE}cd dashboard && npm install && npm run dev${NC}"
    echo -e "  Then open http://localhost:3000"
    echo ""
    echo -e "${YELLOW}Press Ctrl+C to stop the bot.${NC}"
    echo ""

    cd "$PROJECT_ROOT/bot"
    if [ -d "venv" ]; then
        . venv/bin/activate 2>/dev/null || . venv/Scripts/activate 2>/dev/null || true
    fi
    python -m src.main
}

main
