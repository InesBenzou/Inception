#!/bin/bash
#responsible for installing the WordPress CLI, downloading the main WordPress 
#files, creating and configuring the wp-config.php file, and installing WordPress

if [ -d "/var/www/html" ]; then
	echo "Suppression de l'ancien repertoire /var/www/html..."
	rm -rf /var/www/html/*
fi


cd /var/www/html
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar

#echo "Attente de MariaDB... "
#until mysql -h mariadb -u root -p$MYSQL_ROOT_PASSWORD -e "SELECT 1" &>/dev/null; do
#	echo "MariaDB n'est pas pret, attente de 5 secondes..."
#	sleep 5
#done 
#echo "MariaDB est pret, lancement de l'installation de WordPress..."
sleep 10

./wp-cli.phar core download --allow-root

rm -rf wp-config.php


./wp-cli.phar config create --dbname=$DB_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost='mariadb' --allow-root

./wp-cli.phar core install --url=ibenzian.42.fr --title='INCEPTION' --admin_user=$WP_AD_USER --admin_password=$WP_AD_PASSWORD --admin_email=$WP_AD_EMAIL --allow-root  --skip-email
#./wp-cli.phar user create bob bob@inception.com --role=author --user_pass=Sciences1995! --allow-root

exec php-fpm7.4 -F
