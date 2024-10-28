#!/bin/bash

#mkdir -p /run/mysqld
#chown -R mysql:mysql /run/mysqld

#if [ ! -d "/var/lib/mysql/mysql" ]; then
	#mysql_install_db --user=mysql --datadir=/var/lib/mysql
#fi

#rm -f /var/lib/mysql/ib_logfile*

#mysqld_safe --skip-networking &
#sleep 5

service mysql start;

mysql -e "CREATE DATABASE IF NOT EXISTS \`${db}\`;"
mysql -e "CREATE USER IF NOT EXISTS \`${dbuser}\`@'localhost' IDENTIFIED BY '${dbpass}';"
mysql -e "GRANT ALL PRIVILEGES ON \`${db}\`.* TO \`${dbuser}\`@'%' IDENTIFIED BY '${dbpass}';"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${dbrootpass}';"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p"$dbrootpass" shutdown || echo "Failed to stop MySQL."

exec mysqld_safe || echo "Failed to start MySQL"

