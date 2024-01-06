.PHONY: help build-local up down logs ps test
.DEFAULT_GOAL := help

DOCKER_TAG := latest
build: ## Build the docker image to deploy
	docker build -t tsubo/gotodo:${DOCKER_TAG} --target deploy ./

build-local: ## Build the docker image to local development
	docker compose build --no-cache

up: ## Do docker compose up with hot reload
	docker compose up -deploy

down: ## Do docker compose down
	docker compose down

logs: ## Tail docker compose logs
	docker compose logs -f

ps: ## Check docker container status
	docker compose ps

test: ## Execute test
	go test -race -shuffle=on ./...

help: ## Show options
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
