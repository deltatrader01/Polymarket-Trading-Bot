.PHONY: help bot dashboard test setup check-env

# Default target
.DEFAULT_GOAL := help

# Colors for output
BLUE := \033[0;34m
GREEN := \033[0;32m
RED := \033[0;31m
NC := \033[0m # No Color

help: ## Show this help message
	@echo "$(BLUE)Gabagool - Polymarket Volatility Arbitrage Bot$(NC)"
	@echo ""
	@echo "$(GREEN)Available commands:$(NC)"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  $(BLUE)%-18s$(NC) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(BLUE)Project:$(NC) bot/ (trading engine), dashboard/ (web UI), docs/ (documentation)"
	@echo "$(BLUE)Repo:$(NC) https://github.com/gabagool222/Gabagool"
	@echo "$(BLUE)Telegram:$(NC) @gabagool222"

setup: ## Create .env from template and show next steps
	@if [ ! -f .env ]; then \
		cp .env.example .env; \
		echo "$(GREEN).env created from .env.example$(NC)"; \
		echo "$(BLUE)Edit .env with your Polymarket credentials and PRIVATE_KEY$(NC)"; \
	else \
		echo "$(BLUE).env already exists$(NC)"; \
	fi

check-env: ## Check if .env exists and warn if unconfigured
	@if [ ! -f .env ]; then \
		echo "$(RED)Error: .env not found. Run: make setup$(NC)"; \
		exit 1; \
	elif grep -q "your_api_key_here" .env 2>/dev/null; then \
		echo "$(RED)Warning: .env contains placeholder values. Edit with real credentials.$(NC)"; \
	else \
		echo "$(GREEN).env found and appears configured$(NC)"; \
	fi

bot: ## Run the trading bot (requires Redis; run from project root)
	@echo "$(GREEN)Starting Gabagool bot...$(NC)"
	@cd bot && (python -m src.main || (echo "$(RED)Install deps first: cd bot && pip install -r requirements.txt$(NC)" && exit 1))

dashboard: ## Run the dashboard (run from project root)
	@echo "$(GREEN)Starting dashboard...$(NC)"
	@cd dashboard && npm run dev

test: ## Run bot tests
	@echo "$(GREEN)Running tests...$(NC)"
	@cd bot && pytest -v 2>/dev/null || (echo "$(BLUE)Install deps: cd bot && pip install -r requirements.txt && pip install pytest$(NC)" && exit 1)

install-bot: ## Install bot Python dependencies
	@cd bot && pip install -r requirements.txt

install-dashboard: ## Install dashboard npm dependencies
	@cd dashboard && npm install
