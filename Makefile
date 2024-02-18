##################################################
# Define Git informations
##################################################
GIT_USER_EMAIL := ChangeMe
GIT_USER_NAME := ChangeMe

##################################################
# Define targets
##################################################

# Set the default target
.DEFAULT_GOAL := help

# Define variables
APACHE_PHP_CONTAINER := apache_php
SHELL := bash
TMP_SYMFONY_DIR := /tmp/symfony
BUILD_DOCKER := docker-compose up -d --build --remove-orphans --force-recreate
PROJECT_ALREADY_CREATED := $(shell docker-compose exec $(APACHE_PHP_CONTAINER) $(SHELL) -c "if [ -f /app/.env ]; then echo 1; else echo 0; fi")

# Define the help target
help:
	@echo "Available targets:"
	@echo "  init-dev    Initialize dev environment with docker"
	@echo "  clear       Clear the cache"
	@echo "  start       Start the project"
	@echo "  database    Create the database"

# Define the init-dev target to initialize dev environment with docker
init-dev:
ifeq ($(PROJECT_ALREADY_CREATED), 1)
	@echo "Project already created. Starting the project..."
	make start
else
	@echo "Building the Docker containers..."
	$(BUILD_DOCKER)
	
	@echo "Configuring Git..."
	docker-compose exec $(APACHE_PHP_CONTAINER) $(SHELL) -c \
	"git config --global user.email '$(GIT_USER_EMAIL)' && git config --global user.name '$(GIT_USER_NAME)'"

	@echo "Creating Symfony project..."
	docker-compose exec $(APACHE_PHP_CONTAINER) $(SHELL) -c "symfony new --webapp $(TMP_SYMFONY_DIR)"
	docker-compose exec $(APACHE_PHP_CONTAINER) $(SHELL) -c "rm -f $(TMP_SYMFONY_DIR)/compose*.yaml && mv $(TMP_SYMFONY_DIR)/* /app && mv $(TMP_SYMFONY_DIR)/.* /app && rm -rf $(TMP_SYMFONY_DIR)"

	@echo "Installing symfony/apache-pack..."
	docker-compose exec $(APACHE_PHP_CONTAINER) $(SHELL) -c "composer config extra.symfony.allow-contrib true"
	docker-compose exec $(APACHE_PHP_CONTAINER) $(SHELL) -c "composer require symfony/apache-pack"
	
	@echo "Starting the project..."
	make start
endif

# Define the clean target
clear:
	symfony console cache:clear

# Define the start target to start project
start:
	$(BUILD_DOCKER)
	docker-compose exec $(APACHE_PHP_CONTAINER) $(SHELL) -c "symfony server:start -d"
	make clear

# Define the database target to create the database
database:
	docker-compose exec $(APACHE_PHP_CONTAINER) $(SHELL) -c "symfony console doctrine:database:create"