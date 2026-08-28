.DEFAULT_GOAL := help

.PHONY: help install build serve pre-commit pre-commit-install check clean

help: ## Show this help message
	@echo "Available commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install locked dependencies
	uv sync --locked

build: ## Build the documentation site
	uv run zensical build --clean

serve: ## Start the local documentation server
	uv run zensical serve

pre-commit: ## Run all pre-commit hooks
	pre-commit run --all-files

pre-commit-install: ## Install pre-commit as a Git hook
	pre-commit install

check: ## Run all checks
	@make build
	@make pre-commit

clean: ## Remove generated files and caches
	rm -rf .cache/ site/
