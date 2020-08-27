#!/bin/sh

composer install
php artisan cache:clear

#Production
#php artisan migrate --no-interaction --force

chown -R www-data:www-data /home/storage
chown -R www-data:www-data /home/bootstrap/cache

supervisord -c /home/process/supervisord.conf -n
