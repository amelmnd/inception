#!/bin/sh

apk add php83 fcgi php83-cgi php83-mysqli php83-phar php83-mbstring php83-fpm

apk add netcat-openbsd

echo "waiting for mariadb"
while nc -z mariadb 3306 &>/dev/null; [ $? != 0 ]; do
	sleep 1
done
echo "Done waiting mariadb"

if [ ! -e "/var/www/wordpress/index.php" ]; then
mkdir -p /var/www/
wget https://wordpress.org/latest.tar.gz
tar xzf latest.tar.gz -C /var/www/
rm latest.tar.gz
cd /var/www/wordpress

# installation de wp-cli, qui est un outil pour paremetre wordpress
# en ligne de commande
wget \
"https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar" \
-O /usr/bin/wp
chmod +x /usr/bin/wp

ln -sf /usr/bin/php83 /usr/bin/php
fi
wp config create --dbname=wordpress --dbuser=user --dbpass=password --dbhost=localhost --dbprefix=wp_
wp core install --url=${DOMAIN_NAME} --title="Inception" --admin_user=${WP_ADMIN} --admin_password=${WP_ADMIN_PWD} --admin_email=${WP_ADMIN_EMAIL}
wp --allow-root user create ${MDB_USER} ${WP_USER_EMAIL} --role="author" --user_pass=${MDB_USER_PWD}
wp theme install the-bootstrap-blog --activate

php-fpm83 -F