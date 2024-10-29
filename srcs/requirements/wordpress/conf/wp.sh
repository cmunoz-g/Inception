#!/bin/bash

# script to configure wordpress with wp-cli

#echo "Waiting for database"
#sleep 10 # delaying the script to make sure the database is created beforehand

until mysqladmin ping -h "mariadb" --silent; do
    #echo "Waiting for database to be ready..."
    sleep infinity # test
done

if [ -f /var/www/wordpress/wp-config.php ]; then
	echo "Config. file exists"
	exit 0
fi

wp core download --allow-root --path='/var/www/wordpress'

echo "Creating wp-config.php"
wp config create --allow-root \
--dbname="${db}" \
--dbuser="${dbuser}" \
--dbpass="${dbpass}" \
--dbhost=mariadb:3306 \
--path='/var/www/wordpress' || echo "wp-config.php failed"

# running WordPress setup: site title, admin username, email
echo "Running WordPress installation"
wp core install --allow-root \
--title="cmunoz-g" \
--admin_user="cmunoz-g" \
--admin_email="cmunoz-g@student.42madrid.com" \
--path='/var/www/wordpress' \
--skip-email || echo "Wordpress installation failed"

# creating a new user
echo "Creating additional user"
wp user create --allow-root \
"cmunoz-g_clone" "noemail@email.com" \
--role=author \
--path='/var/www/wordpress' \ || echo "Additional user creation failed"

echo "WordPress setup complete!"