FROM debian:12.11

RUN apt-get update && apt-get upgrade && apt-get install -y nginx 

COPY ./conf/default.conf /etc/nginx/conf.d/default.conf
COPY ./tools /etc/nginx/certs

CMD ["nginx", "-g", "daemon off;"]
