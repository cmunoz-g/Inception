FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y php-fpm php-mysqli curl
RUN mkdir -p /run/php

COPY www.conf /etc/php/7.4/fpm/pool.d/.
COPY wp.sh .
RUN chmod +x wp.sh

CMD ["./wp.sh"]