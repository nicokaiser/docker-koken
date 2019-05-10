FROM php:7.1-apache

RUN apt-get update && apt-get install -y \
    graphicsmagick graphicsmagick-imagemagick-compat \
    pwgen wget unzip libcurl4-gnutls-dev \
    libmcrypt4 libmcrypt-dev zlib1g zlib1g-dev \
    && rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-install curl exif mcrypt mysqli pdo_mysql zip

# set recommended PHP.ini settings
# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
        echo 'opcache.memory_consumption=128'; \
        echo 'opcache.interned_strings_buffer=8'; \
        echo 'opcache.max_accelerated_files=4000'; \
        echo 'opcache.revalidate_freq=60'; \
        echo 'opcache.fast_shutdown=1'; \
        echo 'opcache.enable_cli=1'; \
    } > /usr/local/etc/php/conf.d/opcache-recommended.ini
RUN a2enmod rewrite

RUN touch /usr/local/etc/php/conf.d/uploads.ini \
    && echo "upload_max_filesize = 50M;" >> /usr/local/etc/php/conf.d/uploads.ini \
    && echo "post_max_size = 55M;" >> /usr/local/etc/php/conf.d/uploads.ini

VOLUME /var/www/html

ADD https://s3.amazonaws.com/koken-installer/releases/Koken_Installer.zip /usr/local/src/Koken_Installer.zip
ADD https://s3.amazonaws.com/koken-installer/releases/pclzip.lib.txt /usr/local/src/pclzip.lib.php
ADD https://s3.amazonaws.com/koken-installer/releases/latest.zip /usr/local/src/core.zip
ADD https://koken-store.s3.amazonaws.com/plugins/be1cb2d9-ed05-2d81-85b4-23282832eb84.zip /usr/local/src/elementary.zip

RUN unzip -d /usr/local/src /usr/local/src/Koken_Installer.zip \
    && rm /usr/local/src/Koken_Installer.zip

COPY docker-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["apache2-foreground"]
