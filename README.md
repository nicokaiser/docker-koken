# Docker container with Koken and Apache

The container provided by Koken uses nginx and php-fpm, but also provides its own MySQL instance. This container is meant to be lightweight and extensible, uses the current PHP version and can be linked with an external MySQL/MariaDB instance.

# How to use this image

```console
$ docker run --name some-koken --hostname koken.example.com --link some-mysql:mysql -p 80:80 -d wordpress
```

The `hostname` must be accessible from inside the container, so it must be the hostname that is visible from the outside (for lookback connections).

Upon first run, the Koken installer will run.

## ... via [`docker-compose`](https://github.com/docker/compose)

Example `docker-compose.yml`:

```yaml
version: '2'

services:

  koken:
    image: nicokaiser/koken
    ports:
      - 80:80
    volumes:
      - /srv/docker/koken/html:/var/www/html

  mysql:
    image: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: example
```
