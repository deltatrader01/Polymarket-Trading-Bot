#!/bin/bash

# Gabagool Dashboard Start Script

echo "🚀 Starting Gabagool Volatility Arbitrage Dashboard"
echo ""

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
    echo ""
fi

# Check if .env.local exists
if [ ! -f ".env.local" ]; then
    echo "⚙️  Creating .env.local from example..."
    cp .env.local.example .env.local
    echo "✅ Created .env.local - set NEXT_PUBLIC_API_URL if bot is not on localhost:8000"
    echo ""
fi

# Check if bot API is running
echo "🔍 Checking bot API connection..."
if curl -s http://localhost:8000/api/status > /dev/null 2>&1; then
    echo "✅ Bot API is running on http://localhost:8000"
else
    echo "⚠️  Warning: Bot API not detected on http://localhost:8000"
    echo "   Start the bot first (e.g. make bot or ./scripts/start-dev.sh from project root)"
fi

echo ""
echo "🎯 Starting development server..."
echo "   Dashboard will be available at: http://localhost:3000"
echo ""

npm run dev
