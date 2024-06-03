#!/bin/sh
apk add mariadb mariadb-client

# le dossier ou mysql va tourner
if [ ! -d "/run/mysqld" ]; then
	mkdir -p /run/mysqld
	chown -R mysql:mysql /run/mysqld
fi

# Si on a pas le dossier qui contient la base de donne, initialise mariadb
# base de donne.
if [ ! -d "/var/lib/mysql/mysql" ]; then
	mkdir -p "/var/lib/mysql/"
	chown -R mysql:mysql /var/lib/mysql
	mysql_install_db --user=mysql --ldata=/var/lib/mysql
fi

# Si on a jamais creer notre base de donnee, alors il faut la creer
if [ ! -d "/var/lib/mysql/mysql/$DB_NAME" ]; then
    sqlfile=$(mktemp)
    echo "CREATE DATABASE $DB_NAME" >> "$sqlfile"
    echo "USE $DB_NAME;" >> "$sqlfile"
    echo "CREATE TABLE IF NOT EXITS $DB_NAME_TAB (" >> "$sqlfile"
    echo "  id INT AUTO_INCREMENT PRIMARY KEY," >> "$sqlfile"
    echo "  name VARCHAR(100) NOT NULL" >> "$sqlfile"
    echo ");" >> "$sqlfile"
    echo "CREATE USER  $DB_USER " >> "$sqlfile"
    echo "IDENTIFIED by '$DB_U_PWD';" >> "$sqlfile"
    echo "is creat"
    /usr/bin/mysqld --user=mysql \
        --bootstrap \
        --verbose=0 \
        --skip-name-resolve \
        --skip-networking=0 < "$sqlfile"

fi

# Et enfin lance mysql. cette commande tourne jusqu'a l'arret du conteneur
exec /usr/bin/mysqld --user=mysql --console --skip-name-resolve --skip-networking=0