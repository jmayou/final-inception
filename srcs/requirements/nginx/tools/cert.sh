#!/bin/bash

if [ ! -f /etc/nginx/ssl/server.key ]; then
    openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/server.key \
        -out /etc/nginx/ssl/server.crt \
        -subj "/C=MA/ST=tetouan/L=tetouan/O=42/OU=1337/CN=$DOMAIN_NAME"
fi

exec nginx -g "daemon off;"
