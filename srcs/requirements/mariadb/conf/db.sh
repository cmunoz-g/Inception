#!/bin/bash

#mkdir -p /var/run/mysqld
#chmod 755 /var/run/mysqld
#chown -R mysql:mysql /var/run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB directly in the background

mysqld_safe --skip-networking &
sleep 10 || echo "Failed to start MySQL"

# Attempt database setup commands with error checking
if [ ! -f db1.sql ]; then 
	echo "CREATE DATABASE IF NOT EXISTS $db;" >> db1.sql
	echo "CREATE USER IF NOT EXISTS '$dbuser'@'%' IDENTIFIED BY '$dbpass';" >> db1.sql
	echo "GRANT ALL PRIVILEGES ON *.* TO '$dbuser'@'%' WITH GRANT OPTION;" >> db1.sql
	echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$dbrootpass' ;" >> db1.sql
	echo "FLUSH PRIVILEGES;" >> db1.sql
	mysql -u root -p"$dbrootpass" < db1.sql && echo "Executed SQL script" || echo "Failed to execute SQL script."

	mysqladmin -u root -p"$dbrootpass" shutdown || echo "Failed to stop MySQL."
fi

echo "Restarting MySQL"
exec mysqld_safe || echo "Failed to start mysqld."