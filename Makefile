#colors
RESET_COLOR = \033[0;39m
RED = \033[0;91m
GREEN = \033[0;92m
BLUE = \033[0;94m
YELLOW = \e[0;33m

#docker compose configuration
COMPOSE_FILE = ./srcs/docker-compose.yml
COMPOSE = docker compose -f $(COMPOSE_FILE)

###

all: build

# add volumes
build:
	@$(COMPOSE) up -d --build
	@echo "$(GREEN)Project started successfully. Containers are up and running$(RESET_COLOR)"

stop:
	@$(COMPOSE) stop
	@echo "$(BLUE)Containers stopped.$(RESET_COLOR)"

clean:
	@$(COMPOSE) down -v --remove-orphans
	@echo "$(BLUE)Containers and volumes removed.$(RESET_COLOR)"

delete: clean
	@docker system prune -af --volumes
	@echo "$(RED)All Docker resources were pruned.$(RESET_COLOR)"

logs:
	@$(COMPOSE) logs -f
	@echo "$(YELLOW)Showing logs for all services...$(RESET_COLOR)"

ps:
	@$(COMPOSE) ps
	@echo "$(YELLOW)Listing all running containers.$(RESET_COLOR)"

re: clean all
	@echo "$(GREEN)Project restarted successfully.$(RESET_COLOR)"

.PHONY: all build stop clean delete logs ps re