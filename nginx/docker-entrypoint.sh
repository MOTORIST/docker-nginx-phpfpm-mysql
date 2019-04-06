#!/usr/bin/env bash

set -eu

mkdir -p /etc/nginx/ssl/.well-known/acme-challenge;
chown -R root:www-data /etc/nginx/ssl;

if [[ $NGINX_SSL_CERT == "yes" ]]; then
    mkdir -p /etc/nginx/include;
    envsubst '$$NGINX_ROOT_FRONTEND' < /etc/nginx/ssl.redirect.template > /etc/nginx/include/ssl.redirect.conf
    cat /etc/nginx/ssl_config.template > /etc/nginx/include/ssl_config.conf
fi

envsubst '$$NGINX_ROOT_FRONTEND $$NGINX_ROOT_BACKEND $$NGINX_SERVER_NAME_FRONTEND $$NGINX_SERVER_NAME_BACKEND $$NGINX_PORT' < /etc/nginx/nginx.template > /etc/nginx/nginx.conf

nginx -g "daemon off;"