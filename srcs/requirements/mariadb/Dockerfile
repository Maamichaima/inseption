FROM debian:12.4

RUN apt-get update && apt-get install -y \
    mariadb-server 

COPY ./tools/preparDataBase.sh /docker-entrypoint-initdb.d/

COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

CMD ["/docker-entrypoint-initdb.d/preparDataBase.sh"]
