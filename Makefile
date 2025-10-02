DCFILE = ./docker-compose.yaml

ENV_FILE = .env

REQUIRED_VARS = DB_NAME DB_USER DB_PASSWORD DB_HOST DB_ROOT_PASSWORD


all: start

check_env:
	@if [ ! -f $(ENV_FILE) ]; then \
		echo "❌ Le fichier $(ENV_FILE) est manquant"; \
		exit 1; \
	fi; \
	for var in $(REQUIRED_VARS); do \
		if ! grep -q "^$$var=" $(ENV_FILE); then \
			echo "❌ La variable $$var est manquante dans $(ENV_FILE)"; \
			exit 1; \
		fi; \
	done; \
	echo "✅ Toutes les variables requises sont présentes dans $(ENV_FILE)"

start: check_env
	@echo "🚀 Démarrage"
	docker-compose -f $(DCFILE) up -d --build

clean: down
	@if [ "$(shell docker ps -q)" ]; then docker stop $(shell docker ps -q); fi
	@if [ "$(shell docker ps -aq)" ]; then docker rm $(shell docker ps -aq); fi
	@if [ "$(shell docker volume ls -q)" ]; then docker volume rm $(shell docker volume ls -q); fi

fclean: clean
	@if [ "$(shell docker image ls -q)" ]; then docker rmi -f $(shell docker image ls -q); fi
	docker system prune
	rm -rf /home/mminet/data

re: clean all

up: down
	docker-compose -f $(DCFILE) up -d
down:
	docker-compose -f $(DCFILE) down