FROM debian:12

RUN apt-get update

RUN apt-get install -y \
    php-fpm php-mysql wget curl tar iputils-ping

RUN curl -o /usr/local/bin/wp -L https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp

RUN mkdir -p /run/php

COPY ./tools/run.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/run.sh

WORKDIR /var/www/html

CMD ["run.sh"]
