# Colors
DEF_COLOR 	= 	\033[0;39m
RED 		= 	\033[0;91m
GREEN 		=	\033[0;92m
BLUE 		=	\033[0;94m
CYAN 		= 	\033[0;96m

# Config
OBJF 		=	.cache_exists
MAKEFLAGS 	+=	--no-print-directory
.SILENT:

# Docker Compose Configuration
# for the VM, change docker-compose for docker compose
COMPOSE_FILE = ./srcs/docker-compose.yml
DOCKER_COMPOSE = docker compose -f $(COMPOSE_FILE)

###

all: build

# @mkdir -p /home/cmunoz-g/Ivolumes/mariadb
# @mkdir -p /home/cmunoz-g/Ivolumes/wordpress

build:
	@mkdir -p /home/vboxuser/Ivolumes/mariadb
	@mkdir -p /home/vboxuser/Ivolumes/wordpress
	@$(DOCKER_COMPOSE) up -d --build
	@echo "$(GREEN)Project started successfully! Containers are up and running.$(DEF_COLOR)"

stop:
	@$(DOCKER_COMPOSE) stop
	@echo "$(BLUE)Containers stopped.$(DEF_COLOR)"

clean: 
	@$(DOCKER_COMPOSE) down -v --remove-orphans
	@echo "$(CYAN)Containers and volumes removed.$(DEF_COLOR)"

# @rm -rf /home/cmunoz-g/Ivolumes/wordpress
# @rm -rf /home/cmunoz-g/Ivolumes/mariadb 

# take out sudo from the rm -rf, decide where im going to put the volumes and handle permissions

delete: clean
	@docker system prune -af --volumes
	@rm -rf home/vboxuser/Ivolumes/wordpress
	@rm -rf home/vboxuser/Ivolumes/mariadb
	
	@echo "$(RED)All unused Docker resources have been pruned.$(DEF_COLOR)"

logs:
	@$(DOCKER_COMPOSE) logs -f
	@echo "$(YELLOW)Showing logs for all services...$(DEF_COLOR)"

ps:
	@$(DOCKER_COMPOSE) ps
	@echo "$(MAGENTA)Listing all running containers for the project.$(DEF_COLOR)"

re: clean all
	@echo "$(GREEN)Project restarted successfully!$(DEF_COLOR)"

.PHONY: all stop clean delete logs ps re