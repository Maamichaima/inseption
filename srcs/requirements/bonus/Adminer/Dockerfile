FROM debian:12.4

RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-gd \
    php-mysql \
    php-mbstring \
    php-ctype \
    php-json \
    wget \
    libpng-dev \
    libjpeg-dev

RUN mkdir -p /var/www/html

WORKDIR /var/www/html

RUN wget -O index.php https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php && \
    chmod 644 index.php

CMD ["php", "-S", "0.0.0.0:8081", "-t", "/var/www/html"]


