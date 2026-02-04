SHELL := /bin/bash
ENV_FILE ?= .env
COMPOSE := docker compose --env-file $(ENV_FILE)

TRAEFIK_COMPOSE := -f traefik/docker-compose.yml
POSTGRES_COMPOSE := -f postgresql/docker-compose.yml
POSTGRES_DEBUG_COMPOSE := -f postgresql/docker-compose.yml -f postgresql/docker-compose.debug.yml
PGADMIN_COMPOSE := -f pgadmin/docker-compose.yml
PORTAINER_COMPOSE := -f Portainer/docker-compose.yml
ALL_COMPOSE := $(TRAEFIK_COMPOSE) $(POSTGRES_COMPOSE) $(PGADMIN_COMPOSE) $(PORTAINER_COMPOSE)

.PHONY: check-env init up-traefik up-postgresql up-postgresql-debug up-pgadmin up-portainer up-all \
	down-all recreate-traefik recreate-postgresql recreate-postgresql-debug recreate-pgadmin \
	recreate-portainer recreate-all ps logs

check-env:
	@test -f $(ENV_FILE) || (echo "Missing $(ENV_FILE). Copy .env.example to .env first." && exit 1)

init: check-env
	./scripts/init-network.sh

up-traefik: init
	$(COMPOSE) $(TRAEFIK_COMPOSE) up -d

up-postgresql: init
	$(COMPOSE) $(POSTGRES_COMPOSE) up -d

up-postgresql-debug: init
	$(COMPOSE) $(POSTGRES_DEBUG_COMPOSE) up -d

up-pgadmin: init
	$(COMPOSE) $(PGADMIN_COMPOSE) up -d

up-portainer: init
	$(COMPOSE) $(PORTAINER_COMPOSE) up -d

up-all: up-traefik up-postgresql up-pgadmin up-portainer

down-all: check-env
	$(COMPOSE) $(PORTAINER_COMPOSE) down
	$(COMPOSE) $(PGADMIN_COMPOSE) down
	$(COMPOSE) $(POSTGRES_DEBUG_COMPOSE) down
	$(COMPOSE) $(TRAEFIK_COMPOSE) down

recreate-traefik: init
	$(COMPOSE) $(TRAEFIK_COMPOSE) up -d --force-recreate traefik

recreate-postgresql: init
	$(COMPOSE) $(POSTGRES_COMPOSE) up -d --force-recreate db

recreate-postgresql-debug: init
	$(COMPOSE) $(POSTGRES_DEBUG_COMPOSE) up -d --force-recreate db

recreate-pgadmin: init
	$(COMPOSE) $(PGADMIN_COMPOSE) up -d --force-recreate pgadmin

recreate-portainer: init
	$(COMPOSE) $(PORTAINER_COMPOSE) up -d --force-recreate portainer

recreate-all: recreate-traefik recreate-postgresql recreate-pgadmin recreate-portainer

ps: check-env
	$(COMPOSE) $(ALL_COMPOSE) ps

logs:
	@test -n "$(SERVICE)" || (echo "Usage: make logs SERVICE=<container_name>" && exit 1)
	docker logs -f $(SERVICE)
