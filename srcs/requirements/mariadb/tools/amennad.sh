#!/bin/sh

apk add mariadb mariadb-client
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

if [ ! -d "/var/lib/mysql/mysql" ]; then
	mkdir -p "/var/lib/mysql/"
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

if [ ! -d "/var/lib/mysql/mysql/$DB_NAME" ]; then
sqlfile=$(mktemp)

cat << EOF > "$sqlfile"
USE mysql;
FLUSH PRIVILEGES;
GRANT ALL ON *.* TO 'root'@'localhost' IDENTIFIED BY '$DB_ADM_PASS' WITH GRANT OPTION ;
SET PASSWORD FOR 'root'@'localhost'=PASSWORD('$DB_ADM_PASS');
DROP DATABASE IF EXISTS test;
CREATE DATABASE IF NOT EXISTS $DB_NAME CHARACTER SET utf8 COLLATE utf8_general_ci;
CREATE OR REPLACE USER '$DB_USER'@'localhost' IDENTIFIED BY '$DB_USER_PWD';
GRANT ALL ON $DB_NAME.* TO '$DB_USER' IDENTIFIED BY '$DB_USER_PWD';
FLUSH PRIVILEGES;
EOF
/usr/bin/mysqld --user=mysql \
	--bootstrap \
	--verbose=0 \
	--skip-name-resolve \
	--skip-networking=0 < "$sqlfile"
# rm -f "$sqlfile"
fi


exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0
