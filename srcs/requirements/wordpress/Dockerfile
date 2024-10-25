FROM debian:buster

# update packages
RUN apt update -y && apt upgrade -y && apt install -y wget

# install php
RUN apt-get install -y php7.3 php-fpm php-mysql mariadb-client

# copying conf file
COPY /conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# install wordpress
RUN wget https://wordpress.org/wordpress-6.6.2.tar.gz -P /var/www
RUN cd /var/www && tar -xvf wordpress-6.6.2.tar.gz && rm wordpress-6.6.2.tar.gz
RUN chown -R root:root /var/www/wordpress

# configuring wordpress with cli tool
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar 
RUN mv wp-cli.phar /usr/local/bin/wp
