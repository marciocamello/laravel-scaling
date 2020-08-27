#!/bin/sh

echo "🎬 entrypoint.sh"

composer install --no-interaction --prefer-dist --optimize-autoloader

echo "🎬 artisan commands"

php artisan cache:clear

if [ -f artisan]
then
    php artisan migrate --force
fi

echo "🎬 rewrite permissions"

chown -R www-data:www-data /home/storage
chown -R www-data:www-data /home/bootstrap/cache

echo "🎬 start supervisord"

supervisord -c $LARAVEL_PATH/.deploy/process/supervisord.conf
