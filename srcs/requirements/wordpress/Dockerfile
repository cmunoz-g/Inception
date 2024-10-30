FROM debian:buster

# update packages
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y wget

# install php
RUN apt-get install -y php7.3 php-fpm php-mysql mariadb-client

# copying conf file
COPY /conf/www.conf /etc/php/7.3/fpm/pool.d/www.conf

# there may be redundancy here below. wp core install already installs it?? 
# Consider moving the installation all to the .sh, check GitHub

# install wordpress
#RUN wget https://wordpress.org/wordpress-6.6.2.tar.gz -P /var/www
#RUN cd /var/www && tar -xvf wordpress-6.6.2.tar.gz && rm wordpress-6.6.2.tar.gz && chown -R root:root /var/www/wordpress

# removes previous wp-cli.phar if it exists
RUN rm -f /usr/local/bin/wp 
# downloading wp-cli to configure wordpress with commands
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar 
RUN mv wp-cli.phar /usr/local/bin/wp

# copy the conf. file
COPY conf/wp.sh .
RUN chmod +x wp.sh

# fix possible php error
RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["./wp.sh"] 
# launch php
CMD ["/usr/sbin/php-fpm7.3", "-F"] 