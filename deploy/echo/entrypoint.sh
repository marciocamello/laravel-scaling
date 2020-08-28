#!/bin/sh

echo "🎬 start supervisord"

supervisord -c $LARAVEL_PATH/deploy/cron/process/supervisord.conf
