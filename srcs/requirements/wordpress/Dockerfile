FROM debian:bullseye

RUN apt update && apt upgrade && apt install -y php-fpm
RUN mkdir -p /run/php

CMD ["php-fpm7.4", "-F"]