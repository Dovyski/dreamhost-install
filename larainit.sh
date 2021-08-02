#!/bin/bash

# Initializes a Laravel app and make it ready to run

cp .env.example .env
composer install -q --no-ansi --no-interaction --no-scripts --no-suggest --no-progress --prefer-dist
php artisan key:generate
php artisan migrate
php artisan db:seed
php artisan storage:link
npm install
npm run prod

echo -e "Informed app url:\e[1;32m $(cat .env | awk '/^APP_URL=/{print $1}' | sed 's/APP_URL=//') \e[0m"
echo -e "\e[1;32m All goode! \e[0m"