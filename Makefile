
all: up

up:
	@docker-compose -f ./srcs/docker-compose.yml up --build -d
	@docker-compose -f ./srcs/docker-compose.yml start




.phony: all, up