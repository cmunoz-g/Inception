#!/bin/bash

# script to configure wordpress with wp-cli

#echo "Waiting for database"
#sleep 10 # delaying the script to make sure the database is created beforehand

until mysqladmin ping -h "mariadb" --silent; do
    echo "Waiting for database to be ready..."
    sleep 10
done

if [ -f /var/www/wordpress/wp-config.php ]; then
	echo "Config. file exists"
	exit 0
fi

cd /var/www/html
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 1> /dev/null
chmod +x wp-cli.phar

./wp-cli.phar core download --allow-root --path='/var/www/wordpress' 1> /dev/null || echo "Wordpress installation failed"

chown -R www-data:www-data /var/www/wordpress
chmod -R 755 /var/www/wordpress

echo "Creating wp-config.php"
./wp-cli.phar config create --allow-root \
--dbname="${db}" \
--dbuser="${dbuser}" \
--dbpass="${dbpass}" \
--dbhost=mariadb:3306 \
--path='/var/www/wordpress' \
--force || echo "wp-config.php creation failed"

# should i consider adding wp variables in .env ?

# running WordPress setup: site title, admin username, email
echo "Running WordPress installation"
./wp-cli.phar core install --allow-root \
--url="cmunoz-g.42.fr" \
--title="cmunoz-g" \
--admin_user="cmunoz-g" \
--admin_email="cmunoz-g@student.42madrid.com" \
--path='/var/www/wordpress' \
--skip-email || echo "Wordpress installation failed"

# creating a new user
echo "Creating additional user"
./wp-cli.phar user create --allow-root \
"cmunoz-g_clone" "noemail@email.com" \
--role=author \
--path='/var/www/wordpress' || echo "Additional user creation failed"

echo "WordPress setup complete!"
