#!/bin/bash

mkdir -p /etc/ssl/private /etc/ssl/certs

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out /etc/ssl/certs/nginx-selfsigned.crt \
-subj "/C=ES/L=MA/O=42/OU=student/CN=cmunoz-g.42.fr"

ls -l /etc/ssl/private /etc/ssl/certs

nginx -g "daemon off;"