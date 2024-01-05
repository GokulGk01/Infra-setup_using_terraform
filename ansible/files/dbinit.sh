#!/usr/bin/env bash

docker exec -it users php artisan migrate
docker exec -it studioapi php artisan migrate
docker exec -it users php artisan db:seed
docker exec -it studioapi php artisan db:seed


