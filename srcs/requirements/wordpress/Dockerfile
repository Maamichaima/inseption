FROM debian:12.4-slim

# Install dependencies
RUN apt-get update && apt-get install -y php8.2-fpm curl php-mysql mariadb-client 
    # mariadb-server \
    # && rm -rf /var/lib/apt/lists/*

WORKDIR /var/www/html/

RUN curl -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
  && chmod +x /usr/local/bin/wp

# RUN wp core download --allow-root

# COPY wp-config.php /var/www/html/
COPY tools/scriptWordpress.sh /root/
RUN chmod +x  /root/scriptWordpress.sh
RUN sed -ir "s/listen = \/run\/php\/php8.2-fpm.sock/listen = 0.0.0.0:9000/1" /etc/php/8.2/fpm/pool.d/www.conf
# Start MariaDB

CMD ["bash", "/root/scriptWordpress.sh"]
# CMD [ "ls" ]
