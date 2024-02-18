# DockerSymfony

Dev runtime for the Symfony web framework based on Docker, working with Apache web server.

### Features

* Install latest Symfony webapp framework with Apache web server configurations
* Use latest PHP stable version with default PHP extensions and configurations
* Install Composer cli, Symfony cli and Git

### Getting Started

1. If not already done, install [Docker Compose](https://docs.docker.com/compose/).
2. Create a new directory for your project
3. Download this repository on your project directory
4. Edit the Makefile to add your personal information for Git :

```
GIT_USER_EMAIL := ChangeMe
GIT_USER_NAME := ChangeMe
```

For example :

```
GIT_USER_EMAIL := john.doe@example.com
GIT_USER_NAME := John Doe
```

5. Build your dev environment using Make :

```
make init-dev
```
