FROM debian:buster 

# installing packages
RUN apt-get update -y && apt-get upgrade -y && apt-get install nginx -y
RUN apt-get install vim -y

# installing openssl, generating certificate and storing it
RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -subj "/C=ES/L=MA/O=42/OU=student/CN=cmunoz-g.42.fr/"


# creating a folder to store config files & copying nginx.conf
RUN mkdir -p /var/run/nginx
COPY /conf/nginx.conf /etc/nginx/sites-available/default
# OLD: COPY /conf/nginx.conf /etc/nginx/nginx.conf

# setting permissions
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

EXPOSE 443

# run NGINX
CMD [ "nginx", "-g", "daemon off;" ]