#!/bin/bash
# Waiting for database connection...
# while ! mysql --user=root --password=password --host=db ping --silent &> /dev/null ; do
#     echo "Waiting for database connection..."
#     sleep 2
# done
if [ -d "/var/www/vendor" ]
then
    cd /var/www/
    composer update
    echo "Dependencies updated"
elif [ "$(ls -A "/var/www/")" ]; 
then
    echo "Take action $DIR is not Empty"
else
    composer create-project --prefer-dist laravel/laravel:^6.0 .
fi
echo "Application key set ...."
php artisan key:generate
chmod -R 777 /var/www/storage
exec "$@"