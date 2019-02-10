# Koken Docker Image

The image uses PHP 7.1 and Apache for deploying Koken in a Docker environment. This container is meant to be lightweight and extensible, uses the current PHP version and can be linked with an external MySQL/MariaDB instance.

# How to use this image

```console
$ docker run --name some-koken --hostname koken.example.com --link some-mysql:mysql -p 80:80 -d nicokaiser/koken
```

The `hostname` must be accessible from inside the container, so it must be the hostname that is visible from the outside (for lookback connections).

Upon first run, the Koken installer will run.

## ... via [`docker-compose`](https://github.com/docker/compose)

Example `docker-compose.yml`:

```yaml
version: '2'
services:
  koken:
    image: nicokaiser/koken:php7.1-apache
    hostname: koken.example.com
    ports:
      - 80:80
    volumes:
      - koken_data:/var/www/html
  mariadb:
    image: mariadb
    environment:
      MYSQL_ROOT_PASSWORD: example
volumes:
  koken_data:
```
