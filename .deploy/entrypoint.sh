#!/bin/sh

echo "🎬 entrypoint.sh"

composer install --optimize-autoloader --no-dev

echo "🎬 artisan commands"

php artisan cache:clear

#Production
#php artisan migrate --no-interaction --force

echo "🎬 rewrite permissions"

chown -R www-data:www-data /home/storage
chown -R www-data:www-data /home/bootstrap/cache

echo "🎬 start supervisord"

supervisord -c $LARAVEL_PATH/.deploy/process/supervisord.conf
