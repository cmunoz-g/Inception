#!bin/bash

# check if it can be made simpler (github)

service mysql start;

mysql -e "CREATE DATABASE IF NOT EXISTS ${db}\`;"

mysql -e "CREATE USER IF NOT EXISTS \`${dbuser}\`@'localhost' IDENTIFIED BY '${dbpass}';"

mysql -e "GRANT ALL PRIVILEGES ON \`${db}\`.* TO \`${dbuser}\`@'%' IDENTIFIED BY '${dbpass}';"

mysql -e "ALTER USER 'root'@'localhost'	IDENTIFIED BY '${dbrootpass}';"

mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root -p$dbrootpass shutdown

exec mysqld_safe
