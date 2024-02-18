# DockerSymfony

Dev runtime for the Symfony web framework based on Docker, working with Apache, MySQL and phpMyAdmin.

### Features

* Install latest Symfony webapp framework with Apache web server configurations
* Install MySQL and phpMyAdmin to manage the database
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

6. Open http://localhost:8080 in your favorite web browser and start coding your project !

# Next Steps

### Database configuration

At first, get the MySQL database version :

```
docker-compose exec mysql bash -c "mysql --version"
```

To use MySQL, edit your .env configuration file on your project as below :

```
DATABASE_URL="mysql://<USER>:<PASSWORD>@<MYSQL_DOCKER_CONTAINER>:<MYSQL_DOCKER_CONTAINER_PORT>/<DATABASE_NAME>?serverVersion=<MYSQL_VERSION>&charset=utf8mb4"
```

With :
* USER : MySQL user (by default it's "root")
* PASSWORD : MySQL user password (empty by default)
* MYSQL_DOCKER_CONTAINER : MySQL Docker container name (by default it's "mysql")
* MYSQL_DOCKER_CONTAINER_PORT : MySQL Docker container port (by default it's "3306")
* DATABASE_NAME : database name as you want
* MYSQL_VERSION : MySQL version you got before

Example :

```
DATABASE_URL="mysql://root:@mysql:3306/app?serverVersion=8.0.27&charset=utf8mb4"
```

Then, create the database :

```
make database
```

### Manage your database with phpMyAdmin

Open http://localhost:8081 to manage your database.