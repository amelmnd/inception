
all: up

up:
	@cd srcs && docker-compose up --build -d
	@docker-compose start


down:
	@docker-compose -f ./srcs/docker-compose.yml down

stop:
	@docker-compose -f ./srcs/docker-compose.yml stop

start:
	@docker-compose -f ./srcs/docker-compose.yml start

build:
	@docker-compose -f ./srcs/docker-compose.yml build

clean: stop
	@docker rm $$(docker ps -qa) || true
	@rm -rf ~/amennad/data || true
	@docker rmi -f $$(docker images -qa) || true
	@docker volume rm $$(docker volume ls -q) || true
	@docker network rm $$(docker network ls -q) || true

prune: clean
	@docker system prune -a --volumes -f

fclean: prune

re: fclean up

.phony: all, up, down, stop, start, build, clean, prune, fclean