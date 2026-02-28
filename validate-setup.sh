#!/bin/bash
# Validate Gabagool project setup (structure and key files)

echo "Validating Gabagool Setup..."
echo ""

ERRORS=0

check_file() {
    if [ -f "$1" ]; then
        echo "✓ $1"
    else
        echo "✗ $1 - MISSING"
        ERRORS=$((ERRORS + 1))
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo "✓ $1/"
    else
        echo "✗ $1/ - MISSING"
        ERRORS=$((ERRORS + 1))
    fi
}

echo "Root files:"
check_file ".env.example"
check_file ".gitignore"
check_file "README.md"
check_file "Makefile"

echo ""
echo "Project structure:"
check_dir "bot"
check_dir "dashboard"
check_dir "docs"
check_dir "scripts"

echo ""
echo "Bot:"
check_file "bot/requirements.txt"
check_file "bot/.env.example"
check_file "bot/run.sh"

echo ""
echo "Docs:"
check_file "docs/README.md"
check_file "docs/getting-started.md"
check_file "docs/trading-strategy.md"

echo ""
echo "Scripts:"
check_file "scripts/setup.sh"
check_file "scripts/start-dev.sh"

echo ""
if [ $ERRORS -eq 0 ]; then
    echo "✅ All required files and folders present!"
    echo ""
    echo "Next steps:"
    echo "  1. make setup   (or: cp .env.example .env)"
    echo "  2. Edit .env with Polymarket API key, secret, and PRIVATE_KEY"
    echo "  3. Start Redis, then: make bot"
    echo "  4. Optional: make dashboard"
    echo ""
    echo "Full guide: docs/getting-started.md"
else
    echo "❌ $ERRORS check(s) failed"
    exit 1
fi
