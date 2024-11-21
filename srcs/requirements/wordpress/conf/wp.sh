#!/bin/bash

# script to configure WordPress with wp-cli

# Waiting for the database to be ready
until mysqladmin ping -h "mariadb" --silent; do
    echo "Waiting for database to be ready..."
    sleep 10
done

if [ -f /var/www/html/wp-config.php ]
then
	echo "Config. file exists"
else
cd /var/www/html
wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 1> /dev/null
chmod +x wp-cli.phar

# Downloading WordPress core files into /var/www/html
./wp-cli.phar core download --allow-root --path='/var/www/html' 1> /dev/null || echo "WordPress installation failed"

# Setting ownership and permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

echo "Creating wp-config.php"
./wp-cli.phar config create --allow-root \
--dbname="${db}" \
--dbuser="${dbuser}" \
--dbpass="${dbpass}" \
--dbhost=mariadb:3306 \
--path='/var/www/html' \
--force || echo "wp-config.php creation failed"

# Running WordPress setup: site title, admin username, email
echo "Running WordPress installation"
./wp-cli.phar core install --allow-root \
--url="cmunoz-g.42.fr" \
--title="cmunoz-g" \
--admin_user="cmunoz-g" \
--admin_email="cmunoz-g@student.42madrid.com" \
--path='/var/www/html' \
--skip-email || echo "WordPress installation failed"

# Creating an additional user
echo "Creating additional user"
./wp-cli.phar user create --allow-root \
"cmunoz-g_clone" "noemail@email.com" \
--role=author \
--path='/var/www/html' || echo "Additional user creation failed"

echo "WordPress setup complete!"

fi

/usr/sbin/php-fpm7.3 -F