#!bin/bash

# script to configure wordpress with wp-cli

sleep 3s # delaying the script to make sure the database is created beforehand
if test -f /var/www/wordpress/wp-config.php # checking if the conf file already exists
	wp config create
else
	echo "Config. file exists"
fi