#!/bin/sh

echo "🎬 entrypoint.sh"

composer install --no-interaction --prefer-dist --optimize-autoloader

echo "🎬 artisan commands"

php artisan optimize
php artisan cache:clear
php artisan migrate --force

echo "🎬 rewrite permissions"

chown -R www-data:www-data /home/storage
chown -R www-data:www-data /home/bootstrap/cache

echo "🎬 start supervisord"

supervisord -c $LARAVEL_PATH/deploy/default/process/supervisord.conf
