# IMAGE
FROM php:7.4-fpm-alpine3.11

# MAINTAINER
LABEL Maintainer="Marcio Camello <mac3designer@gmail.com>" \
      Description="Laravel container with NGINX and PHP-FPM"

# APPLICATION DIRECTORY

ENV LARAVEL_PATH=/home
WORKDIR $LARAVEL_PATH

# ADD SITE.SH
COPY ./deploy/default/entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

# ADDING DEPENDENCIES
RUN apk add --no-cache --virtual .build-deps curl wget bash openssl libstdc++ \
    nodejs npm openssl-dev git nano unzip \
    autoconf make pkgconf g++ gcc build-base linux-headers \
    musl-dev make libtool git libxml2-dev nginx supervisor curl zlib-dev

# PHP EXTENSIONS
RUN  apk add --no-cache             \
     --virtual .build-deps          \
     nano                           \
     htop                           \
     tini                           \
     libintl                        \
     icu                            \
     icu-dev                        \
     libxml2-dev                    \
     postgresql-dev                 \
     freetype-dev                   \
     libjpeg-turbo-dev              \
     libpng-dev                     \
     gmp                            \
     gmp-dev                        \
     libmemcached-dev               \
     imagemagick-dev                \
     libzip-dev                     \
     libssh2                        \
     libssh2-dev                    \
     libxslt-dev                    \
     g++                            \
    && docker-php-ext-install pdo_mysql \
    && docker-php-ext-install calendar \
    && docker-php-ext-configure intl \
    && docker-php-ext-install intl \
    && docker-php-ext-enable intl \
    && docker-php-ext-install zip \
    && docker-php-ext-install gd \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install pcntl

# Configure PHP-FPM
COPY ./deploy/default/php-fpm/php.ini $PHP_INI_DIR/conf.d/custom.ini

# COMPOSER
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
RUN php composer-setup.php && mv composer.phar /usr/bin/composer

# PECL SETTINGS
RUN pecl channel-update pecl.php.net

# UPDATE COMPOSER
RUN composer self-update

# CRON
#UN echo "* * * * * php /home/artisan schedule:run >> /dev/null 2>&1" >> /etc/crontabs/root

# Remove default server definition
RUN apk add --no-cache nginx supervisor \
    && mkdir -p /run/nginx

# NGINX
COPY ./deploy/default/nginx/conf.d/ /etc/nginx/conf.d/
RUN rm -rf /etc/nginx/sites-enabled
RUN mkdir -p /etc/nginx/sites-enabled

# Copy app
COPY --chown=www-data:www-data . $LARAVEL_PATH/
RUN chmod -R 775 $LARAVEL_PATH/storage

# PERMISSONS
RUN mkdir -p /home/storage && chown -R www-data:www-data /home/storage
RUN mkdir -p /home/bootstrap/cache && chown -R www-data:www-data /home/bootstrap/cache
RUN mkdir -p /home/public && chown -R www-data:www-data /home/public

# Set any ENVs
ARG APP_KEY=${APP_KEY}
ARG APP_NAME=${APP_NAME}
ARG APP_URL=${APP_URL}
ARG APP_ENV=${APP_ENV}
ARG APP_DEBUG=${APP_DEBUG}

ARG LOG_CHANNEL=${LOG_CHANNEL}

ARG DB_CONNECTION=${DB_CONNECTION}
ARG DB_HOST=${DB_HOST}
ARG DB_PORT=${DB_PORT}
ARG DB_DATABASE=${DB_DATABASE}
ARG DB_USERNAME=${DB_USERNAME}
ARG DB_PASSWORD=${DB_PASSWORD}

ARG BROADCAST_DRIVER=${BROADCAST_DRIVER}
ARG CACHE_DRIVER=${CACHE_DRIVER}
ARG QUEUE_CONNECTION=${QUEUE_CONNECTION}
ARG SESSION_DRIVER=${SESSION_DRIVER}
ARG SESSION_LIFETIME=${SESSION_LIFETIME}

ARG REDIS_HOST=${REDIS_HOST}
ARG REDIS_PASSWORD=${REDIS_PASSWORD}
ARG REDIS_PORT=${REDIS_PORT}

ARG MAIL_MAILER=${MAIL_MAILER}
ARG MAIL_HOST=${MAIL_HOST}
ARG MAIL_PORT=${MAIL_PORT}
ARG MAIL_USERNAME=${MAIL_USERNAME}
ARG MAIL_PASSWORD=${MAIL_PASSWORD}
ARG MAIL_ENCRYPTION=${MAIL_ENCRYPTION}
ARG MAIL_FROM_ADDRESS=${MAIL_FROM_ADDRESS}
ARG MAIL_ENCRYPTION=${MAIL_ENCRYPTION}
ARG MAIL_FROM_NAME=${APP_NAME}

# START ALL SERVICES
EXPOSE 80
CMD ["entrypoint.sh"]
