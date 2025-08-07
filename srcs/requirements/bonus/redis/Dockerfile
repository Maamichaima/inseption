FROM debian:12.11

RUN apt-get update && apt-get install -y redis-server
# 0.0.0.0 means Redis will accept connections from any network interface (inside the Docker network).
RUN sed -i 's/bind 127.0.0.1/bind 0.0.0.0/g' /etc/redis/redis.conf
# protected-mode no: Allows external connections to Redis.
RUN echo "protected-mode no" >> /etc/redis/redis.conf
# daemonize no: Keeps Redis running in the foreground, as required by Docker.
RUN echo "daemonize no" >> /etc/redis/redis.conf

CMD ["redis-server", "/etc/redis/redis.conf"]
