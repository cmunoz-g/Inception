FROM debian:buster 

# installing packages
RUN apt update -y && apt install nginx -y 
RUN apt install vim -y

# installing openssl, generating certificate and storing it
RUN mkdir -p /etc/nginx/ssl
RUN apt install openssl -y
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=ES/ST=Madrid/L=Madrid/O=42/OU=42/CN=login.42.fr/UID=cmunoz-g"

# creating a folder to store config files & copying nginx.conf
RUN mkdir -p /var/run/nginx
COPY /conf/nginx.conf /etc/nginx/nginx.conf

# setting permissions
#RUN chmod 755 /var/www/wordpress
#RUN chown -R www-data:www-data /var/www/wordpress

# run NGINX
CMD [ "nginx", "-g", "daemon off;" ]