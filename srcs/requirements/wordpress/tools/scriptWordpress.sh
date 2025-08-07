#!bin/bash

echo "DB_NAME=$MYSQL_DATABASE"
echo "DB_USER=$MYSQL_USER"
echo "DB_PASS=$MYSQL_PASSWORD"
echo "DB_HOST=$DB_HOST:$DB_HOST_PORT"

until mysqladmin ping -h"$DB_HOST" -P"$DB_HOST_PORT" --silent; do
#   echo "Waiting for MariaDB..."
  sleep 2
done

if [ ! -f /var/www/html/wp-config.php ]; then
	wp core download --allow-root
	wp config create \
		--dbname="$MYSQL_DATABASE" \
		--dbuser="$MYSQL_USER" \
		--dbpass="$MYSQL_PASSWORD" \
		--dbhost="$DB_HOST:$DB_HOST_PORT" \
		--allow-root
fi

if ! wp core is-installed --allow-root; then
	wp core install \
	--url="https://cmaami.fr.42" \
	--title="$TITLE" \
	--admin_user="$ADMIN_USER" \
	--admin_password="$ADMIN_USER_PASSWORD" \
	--admin_email="$ADMIN_USER_EMAIL" \
	--skip-email \
	--allow-root
fi
#Sets the Redis server hostname to redis in the WordPress config. This matches your Docker service name, so WordPress can find Redis.
wp config  set WP_REDIS_HOST redis --allow-root
# Sets the Redis server port to 6379 (the default Redis port).
wp config set WP_REDIS_PORT 6379 --allow-root
# Enables caching in WordPress by setting WP_CACHE to true in the config.
wp config  set WP_CACHE 'true' --allow-root
# Installs the Redis Object Cache plugin for WordPress.
wp plugin install redis-cache  --allow-root
# Activates the Redis Object Cache plugin.
wp plugin activate redis-cache  --allow-root
# Enables Redis object caching in WordPress using the plugin.
wp redis enable  --allow-root

php-fpm8.2 -F
