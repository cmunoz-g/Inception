#!/bin/bash

mkdir -p /var/run/mysqld
chmod 755 /var/run/mysqld
chown -R mysql:mysql /var/run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB directly in the background

mysqld_safe --skip-networking &
sleep 10 || echo "Failed to start MySQL"

# Attempt database setup commands with error checking
mysql -e "CREATE DATABASE IF NOT EXISTS \`${db}\`;" || echo "Failed to create database"
mysql -e "CREATE USER IF NOT EXISTS \`${dbuser}\`@'localhost' IDENTIFIED BY '${dbpass}';" || echo "Failed to create user"
mysql -e "GRANT ALL PRIVILEGES ON \`${db}\`.* TO \`${dbuser}\`@'%' IDENTIFIED BY '${dbpass}';" || echo "Failed to grant privileges"
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${dbrootpass}';" || echo "Failed to alter root user password"
mysql -e "FLUSH PRIVILEGES;" || echo "Failed to flush privileges"

mysqladmin -u root -p"$dbrootpass" shutdown || echo "Failed to stop MySQL."

# ls -la /run/mysqld

exec mysqld_safe || echo "Failed to start MySQL"
