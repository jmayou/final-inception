#!/bin/bash

set -eu

wait_for_db() {
    timeout 1 bash -c "</dev/tcp/mariadb/3306" || return 1
}

until wait_for_db; do
    echo "MariaDB not ready yet... waiting"
    sleep 1
done
echo "MariaDB is up!"

if [ ! -f /var/www/html/wp-config.php ]; then
    wget https://wordpress.org/latest.tar.gz
    tar -xzf latest.tar.gz --strip-components=1
    rm latest.tar.gz
    sed -i "s/database_name_here/$MYSQL_DATABASE/" wp-config-sample.php
    sed -i "s/username_here/$MYSQL_USER/" wp-config-sample.php
    sed -i "s/password_here/$MYSQL_PASSWORD/" wp-config-sample.php
    sed -i "s/localhost/mariadb/" wp-config-sample.php
    mv wp-config-sample.php wp-config.php
fi

if ! wp core is-installed --allow-root 2>/dev/null; then
    echo "Installing WordPress..."
    wp core install \
        --allow-root
        --url="${SITE_URL}" \
        --title="${SITE_TITLE}" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
    echo "Creating normal user..."
    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --allow-root 
        --role=author \ 
        --user_pass="${WP_USER_PASSWORD}" \
else
    echo "WordPress if installed"
fi
sed -i "s/^listen = .*/listen = 9000/" /etc/php/8.2/fpm/pool.d/www.conf
exec php-fpm8.2 -F