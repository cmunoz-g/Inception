#!/bin/bash

# script to configure wordpress with wp-cli

echo "Waiting for database"
sleep 10 # delaying the script to make sure the database is created beforehand

if [ -f /var/www/wordpress/wp-config.php ]; then
	echo "Config. file exists"
	exit 0
fi

echo "Creating wp-config.php"
wp config create --allow-root \
--dbname="${db}" \
--dbuser="${dbuser}" \
--dbpass="${dbpass}" \
--dbhost=mariadb \
#--path='/var/www/wordpress'

# running WordPress setup: site title, admin username, email
echo "Running WordPress installation"
wp core install --allow-root \
--title="cmunoz-g" \
--admin_user="cmunoz-g" \
--admin_email="cmunoz-g@student.42madrid.com" \
--skip-email 

# creating a new user
echo "Creating additional user"
wp user create --allow-root \
"cmunoz-g_clone" "noemail@email.com" \
--role=author \
--path='/var/www/wordpress'

echo "WordPress setup complete!"