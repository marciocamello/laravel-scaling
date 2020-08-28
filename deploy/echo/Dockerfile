# IMAGE
FROM node:alpine

# MAINTAINER
LABEL Maintainer="Marcio Camello <mac3designer@gmail.com>" \
      Description="Laravel container with NODEJS"

# APPLICATION DIRECTORY

ENV LARAVEL_PATH=/home
WORKDIR $LARAVEL_PATH

# ADD SITE.SH
COPY ./deploy/echo/entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh

# ADDING DEPENDENCIES
RUN apk add --no-cache --virtual .build-deps curl wget bash openssl libstdc++ \
    openssl-dev git nano unzip \
    autoconf make pkgconf g++ gcc build-base linux-headers \
    musl-dev make libtool git libxml2-dev nginx supervisor curl zlib-dev

# Remove default server definition
RUN apk add --no-cache nginx supervisor \
    && mkdir -p /run/nginx

# NGINX
COPY ./.deploy-laravel/nginx/conf.d/ /etc/nginx/conf.d/
RUN rm -rf /etc/nginx/sites-enabled
RUN mkdir -p /etc/nginx/sites-enabled

# INSTAL NPM GLOBAL DEPENDENCIES
RUN npm -g i cross-env laravel-echo-server

# Copy app
COPY --chown=www-data:www-data ./deploy/echo/.env $LARAVEL_PATH/
COPY --chown=www-data:www-data ./deploy/echo/laravel-echo-server.json $LARAVEL_PATH/
COPY --chown=www-data:www-data ./deploy/echo/index.html $LARAVEL_PATH/

# Set any ENVs
ARG LARAVEL_ECHO_SERVER_AUTH_HOST=${LARAVEL_ECHO_SERVER_AUTH_HOST}
ARG LARAVEL_ECHO_SERVER_REDIS_HOST=${LARAVEL_ECHO_SERVER_REDIS_HOST}
ARG LARAVEL_ECHO_SERVER_REDIS_PORT=${LARAVEL_ECHO_SERVER_REDIS_PORT}
ARG LARAVEL_ECHO_SERVER_REDIS_PASSWORD=${LARAVEL_ECHO_SERVER_REDIS_PASSWORD}

# START ALL SERVICES
EXPOSE 80
CMD ["entrypoint.sh"]
