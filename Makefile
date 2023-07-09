#-------------------- Define Color-------------------#
ifneq (,$(findstring xterm,${TERM}))
	R            := $(shell tput -Txterm setaf 1)
	G            := $(shell tput -Txterm setaf 2)
	Y            := $(shell tput -Txterm setaf 3)
	LP           := $(shell tput -Txterm setaf 4)
	P            := $(shell tput -Txterm setaf 5)
	B            := $(shell tput -Txterm setaf 6)
	W            := $(shell tput -Txterm setaf 7)
	RS := $(shell tput -Txterm sgr0)
else
	R            := ""
	G            := ""
	Y            := ""
	LP           := ""
	P            := ""
	B            := ""
	W            := ""
	RS           := ""
endif
#----------------------------------------------------#

#====================================================================================
#==================================  [Composing]  ===================================
#====================================================================================

up:
# Check the volume directory if they are not exist, create them
	@if [ ! -d home/${USER}/data ]; then \
		mkdir -p /home/${USER}/data/wordpress  /home/${USER}/data/mariadb; \
	fi

# Build the containers
	-@docker-compose -f src/docker-compose.yml up --build

#====================================================================================
stop:
	-@docker-compose -f src/docker-compose.yml down 

	@echo "$(G)【OK】 $(RS)        $(R)❮Inception❯ containers STOPPED$(RS)"
	@echo "$(Y)———————————————————————————————————————————————————————————————————————$(RS)"
#====================================================================================
fclean:
	-@docker-compose -f src/docker-compose.yml down

#	Stop all containers created for the Inception project:
	@if [ ! -z "$$(docker ps -qa)" ]; then \
		docker stop $$(docker ps -qa) && \
		docker rm -f $$(docker ps -qa) && \
		echo "$(G)【OK】 $(RS)        $(R)❮Inception❯ containers STOPPED$(RS)"; \
	fi

# 	Remove all images created for the Inception project:
	@if [ ! -z "$$(docker images -qa)" ]; then \
		docker rmi -f $$(docker images -qa) && \
		echo "$(G)【OK】 $(RS)        $(R)❮Inception❯ images DELETED$(RS)"; \
	fi

#	Remove all networks created for the Inception project:
	@if [ ! -z "$$(docker network ls | grep src_inception)" ]; then \
		docker network rm src_inception && \
		echo "$(G)【OK】 $(RS)        $(R)❮Inception❯ network DELETED$(RS)"; \
	fi

#	Remove all volumes created for the Inception project:
	@if [ ! -z "$$(docker volume ls -q)" ]; then \
		docker volume rm -f $$(docker volume ls -q) && \
		echo "$(G)【OK】 $(RS)        $(R)❮Inception❯ volume DELETED$(RS)"; \
	fi

#	Remove all data from the Inception project:
	@if [ -z "$$(-d /home/${USER}/data)" ]; then \
		sudo rm -rf /home/${USER}/data && \
		echo "$(G)【OK】 $(RS)        $(R)❮Inception❯ data DELETED$(RS)"; \
	fi

	@echo "$(G)【OK】 $(RS)        $(R)❮Inception❯ images && containers DELETED$(RS)"
	@echo "$(Y)———————————————————————————————————————————————————————————————————————$(RS)"


#====================================================================================
#=================  [Run evry container by its own for debugging]  ==================
#====================================================================================

#===================================  [Mariadb]  ====================================
mariadb:
	@docker build -t mariadb_image src/requirements/mariadb/
	@docker run --name mariadb_container -it -d mariadb_image

	@echo "$(Y)———————————————————————————————————————————————————————————————————————$(RS)"
	@echo "$(G)❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮ $(P)Welcome from MariaDB $(G)❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯ $(RS)"
	@echo "$(Y)———————————————————————————————————————————————————————————————————————$(RS)"

	-@docker exec -it mariadb_container /bin/bash
	-@docker stop mariadb_container 
	-@docker rm mariadb_container
	-@docker rmi mariadb_image

	@echo "$(G)【OK】 $(RS)        $(R)❮MariaDB❯ images && containers Deleted$(RS)"

mariadb_clean:
	-@docker stop mariadb_container 
	-@docker rm mariadb_container
	-@docker rmi mariadb_image

	@echo "$(G)【OK】 $(RS)        $(R)❮MariaDB❯ images && containers Deleted$(RS)"
#===================================  [WordPress]  ==================================
wp:
	@docker build -t wordpress_image src/requirements/wordpress
	@docker run --name wordpress_container -it -d wordpress_image
	clear

	@echo "$(Y)———————————————————————————————————————————————————————————————————————$(RS)"
	@echo "$(G)❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮ $(P)Welcome from WordPress $(G)❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯ $(RS)"
	@echo "$(Y)———————————————————————————————————————————————————————————————————————$(RS)"

	-@docker exec -it wordpress_container /bin/bash
	-@docker stop wordpress_container
	-@docker rm wordpress_container
	-@docker rmi wordpress_image

	@echo "$(G)【OK】 $(RS)        $(R)❮WordPress❯ images && containers Deleted$(RS)"
	@echo "$(Y)———————————————————————————————————————————————————————————————————————$(RS)"

wp_clean:
	-@docker stop wordpress_container
	-@docker rm wordpress_container
	-@docker rmi wordpress_image

	@echo "$(G)【OK】 $(RS)        $(R)❮WordPress❯ images && containers Deleted$(RS)"
	@echo "$(Y)———————————————————————————————————————————————————————————————————————$(RS)"
#=====================================  [Nginx]  ====================================
nginx:
	@docker build -t nginx_image src/requirements/nginx
	@docker run --name nginx_container -it -d nginx_image
	clear
	@echo "$(Y)———————————————————————————————————————————————————————————————————————$(RS)"
	@echo "$(G)❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮ $(P)Welcome from Nginx $(G)❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯ $(RS)"
	@echo "$(Y)———————————————————————————————————————————————————————————————————————$(RS)"

	-@docker exec -it nginx_container /bin/bash
	-@docker stop nginx_container
	-@docker rm nginx_container
	-@docker rmi nginx_image

	@echo "$(G)【OK】 $(RS)        $(R)❮Nginx❯ images && containers Deleted$(RS)"

nginx_clean:
	-@docker stop nginx_container
	-@docker rm nginx_container
	-@docker rmi nginx_image

	@echo "$(G)【OK】 $(RS)        $(R)❮Nginx❯ images && containers Deleted$(RS)"
#====================================================================================

.DEFAULT_GOAL := help

.PHONY: help
help:
	@echo "Available rules:"
	@egrep -o '^[a-zA-Z_-]+:([^=]|$$)' $(MAKEFILE_LIST) | awk 'BEGIN {FS=":"} \
		{printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}'

# The .DEFAULT_GOAL variable sets the default target to "help".
# This means that running "make" without specifying a target will execute the "help" target.

# The .PHONY rule declares the "help" target as a phony target.
# Phony targets are targets that do not represent actual files or directories.

# The "help" target displays the available rules in the Makefile.
# It uses the `egrep` command to extract the rule names and descriptions from the $(MAKEFILE_LIST) variable.
# The output is piped to `awk`, where the field separator `FS` is set to ":" using "BEGIN {FS=":"}".
# Then, the rule name and description are formatted and printed using `printf`.
#====================================================================================