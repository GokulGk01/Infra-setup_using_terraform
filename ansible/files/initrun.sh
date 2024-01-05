#!/usr/bin/env bash

service=("users-api" "studioapi" "admin-api" "media-convert" "mediadetails-api" "mediaview-api" "notification-api" "payment-api" "search-api" "shocialactivities-api" "useractions-api" "media-api" "studio" "frontend")
cd /opt/composefiles && for i in ${service[@]}; do cd $i && docker-compose up -d --build && cd - ; done