FROM php:7.0-apache

RUN echo deb http://http.debian.net/debian jessie-backports main >> /etc/apt/sources.list.d/backports.list

RUN apt-get update && apt-get install -y \
    graphicsmagick graphicsmagick-imagemagick-compat \
    pwgen wget unzip ffmpeg libcurl4-gnutls-dev \
    libmcrypt4 libmcrypt-dev zlib1g zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install curl exif mcrypt mysqli pdo_mysql zip

RUN a2enmod rewrite

VOLUME /var/www/html

RUN curl -fsSL -o /usr/local/src/Koken_Installer.zip \
        "https://s3.amazonaws.com/koken-installer/releases/Koken_Installer.zip" \
    && unzip -d /usr/local/src /usr/local/src/Koken_Installer.zip \
    && rm /usr/local/src/Koken_Installer.zip

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
