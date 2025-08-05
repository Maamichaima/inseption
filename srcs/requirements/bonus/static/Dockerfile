FROM debian:12.11

RUN apt-get update -y && apt-get install apache2 -y

COPY ./website /var/www/html

CMD ["apache2ctl", "-D", "FOREGROUND"]