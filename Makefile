# COLOR MAKEFILE
COLOUR_GREEN=\033[0;32m
COLOUR_RED=\033[0;31m
COLOUR_BLUE=\033[0;36m
COLOUR_YELLOW = \033[0;93m
COLOUR_MAGENTA = \033[0;95m
END_COLOR=\033[0m

# VAR
NAME = inception
ORIGIN = main.c

SRC_PATH	:= src/

FILES = $(ORIGIN)

SRCS := $(addprefix $(SRC_PATH), $(FILES))

# RULES
all: $(NAME)


$(NAME): 
	cd srcs
	docker-compose up --build
	@echo "$(COLOR_MAGENTA)docker exec $(NAME) generate 🌸$(END_COLOR)"


	rm -rf for_dev

# Clean
clean:
	@docker stop $(docker ps -aq)
	docker rm $(docker ps -aq)
	@echo "$(COLOUR_BLUE) clean 🐟$(END_COLOR)"

fclean : clean
	@docker rmi $(docker images -q) &&
	docker volume rm $(docker volume ls -q)&&
	docker network prune -f&&
	@echo "$(COLOUR_BLUE) fclean 🐳$(END_COLOR)"

re:fclean all
	@echo "$(COLOUR_MAGENTA)make re OK 🌸$(END_COLOR)"

.PHONY: all clean fclean re run libft debugv debugfa the_end
