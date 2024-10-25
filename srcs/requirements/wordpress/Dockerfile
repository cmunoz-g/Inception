FROM debian:buster

# update packages
RUN apt update -y && apt upgrade -y && apt install -y wget

# install php
RUN apt-get install -y php7.3 php-fpm php-mysql mariadb-client

# install wordpress
RUN wget https://wordpress.org/wordpress-6.6.2.tar.gz -P /var/www
RUN cd /var/www && tar -xvf wordpress-6.6.2.tar.gz && rm wordpress-6.6.2.tar.gz