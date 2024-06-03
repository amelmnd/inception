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

# FOLDER & FILES
# PATH_DEV = $(addprefix $(DIR_X), $(SRCS_Y))
# DIR_DEV = FOLDER/
# SRCS_DEV = FILE.c \

# FILES = $(PATH_X)
FILES = $(ORIGIN)

SRCS := $(addprefix $(SRC_PATH), $(FILES))

# RULES
all: $(NAME)


$(NAME): 
	docker images
	@echo "$(COLOR_MAGENTA)docker exec $(NAME) generate 🌸$(END_COLOR)"


	rm -rf for_dev

# Clean
clean:
	@cd ./include/libft; make clean
	@rm -rf $(OBJS)
	@echo "$(COLOUR_BLUE) clean 🐟$(END_COLOR)"

fclean : clean
	@cd ./include/libft && make fclean
	@rm -rf $(NAME)
	@echo "$(COLOUR_BLUE) fclean 🐳$(END_COLOR)"

re:fclean all
	@echo "$(COLOUR_MAGENTA)make re OK 🌸$(END_COLOR)"

.PHONY: all clean fclean re run libft debugv debugfa the_end
