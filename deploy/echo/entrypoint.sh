#!/bin/sh

echo "🎬 start supervisord"

supervisord -c $LARAVEL_PATH/supervisord.conf
