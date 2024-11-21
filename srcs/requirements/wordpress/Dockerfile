FROM debian:buster

# update packages
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y wget

# install php
RUN apt-get install -y php7.3 php-fpm php-mysql php-mysqli mariadb-client

# copying conf file
COPY conf/www.conf /etc/php/7.3/fpm/pool.d/.

# copy the conf. file
COPY conf/wp.sh .
RUN chmod +x wp.sh

RUN mkdir -p /run/php

EXPOSE 9000

ENTRYPOINT ["./wp.sh"] 
# launch php
#CMD ["/usr/sbin/php-fpm7.3", "-F"] 