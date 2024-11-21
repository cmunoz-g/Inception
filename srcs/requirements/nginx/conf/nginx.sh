#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key \
	-out /etc/ssl/certs/nginx-selfsigned.crt \
	-subj "/C=ES/L=MA/O=42/OU=student/CN=cmunoz-g.42.fr"


echo "
server {
    listen 443;
    listen [::]:443;
    server_name cmunoz-g.42.fr www.cmunoz-g.42.fr;
    return 301 https://\$server_name\$request_uri;
}
" > /etc/nginx/sites-available/default


echo "
server {
    listen 443 ssl;
    listen [::]:443 ssl;

    server_name cmunoz-g.42.fr;

    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
    
    # Add these SSL parameters
    ssl_session_timeout 1d;
    ssl_session_cache shared:SSL:50m;
    ssl_session_tickets off;" > /etc/nginx/sites-available/default


echo '
    ssl_protocols TLSv1.3;

    index index.php;
    root /var/www/html;

    location ~ [^/]\.php(/|$) { 
            try_files $uri =404;
            fastcgi_pass wordpress:9000;
            include fastcgi_params;
            fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
        }
} ' >>  /etc/nginx/sites-available/default

nginx -g "daemon off;"