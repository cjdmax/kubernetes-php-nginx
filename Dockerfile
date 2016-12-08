FROM ubuntu

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y \
  php7.0-fpm \
  nginx

ADD ./docker/nginx/nginx.conf /etc/nginx/nginx.conf
RUN rm /etc/nginx/sites-enabled/default && mkdir /run/php/
ADD ./docker/nginx/sites-enabled/ /etc/nginx/sites-enabled

ADD ./docker/php-fpm/php-fpm.conf /etc/php/7.0/fpm/php-fpm.conf
ADD ./docker/php-fpm/pool.d/ /etc/php/7.0/fpm/pool.d

RUN sed -i "s/;date.timezone =/date.timezone = Europe\/Amsterdam/" /etc/php/7.0/fpm/php.ini

ADD app/ /app

EXPOSE 80 9000

WORKDIR /app
