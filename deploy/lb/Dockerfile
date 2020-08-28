# IMAGE
FROM nginx:latest

# MAINTAINER
LABEL Maintainer="Marcio Camello <mac3designer@gmail.com>" \
      Description="Laravel container with NGINX"

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

# Remove default server definition
RUN apk add --no-cache nginx supervisor \
    && mkdir -p /run/nginx

# NGINX
COPY ./deploy/default/nginx/conf.d/ /etc/nginx/conf.d/
RUN rm -rf /etc/nginx/sites-enabled
RUN mkdir -p /etc/nginx/sites-enabled

# Set any ENVs
ARG APP_ENV=${APP_ENV}

# START ALL SERVICES
EXPOSE 80
CMD ["entrypoint.sh"]
