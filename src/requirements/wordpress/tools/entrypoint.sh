#!/bin/bash

#-------------------------------------------------------------------------------------------
# Create a directory for the WordPress installation
# And set permissions to www-data user
mkdir -p /var/www/html
chown -R www-data:www-data /var/www/html

#-------------------------------------------------------------------------------------------
# Create a directory for the PHP socket file
# And set permissions to www-data user
mkdir -p /run/php
chown -R www-data:www-data /run/php

#-------------------------------------------------------------------------------------------
# Install WordPress using wget and extract the files to the root directory
# then remove the tar file.
wget -q https://wordpress.org/latest.tar.gz 
tar -xzf latest.tar.gz -C /var/www/html/
rm -rf latest.tar.gz
# Set permissions for WordPress files and folders to www-data user
chown -R www-data:www-data /var/www/html/wordpress/

#-------------------------------------------------------------------------------------------
# Check if wp-config.php && static_site exist in the root directory
# If so, move them to the WordPress directory
#### Checking one of them is enough ####

if [ -f ./wp-config.php ]; then
    mv ./wp-config.php /var/www/html/wordpress
    mv /static_site /var/www/html/wordpress/
fi

#-------------------------------------------------------------------------------------------
# configure wp-config.php

sed -i -e "s|WORDPRESS_DB_NAME|'${WORDPRESS_DB_NAME}'|" \
        -e "s|WORDPRESS_DB_USER|'${WORDPRESS_DB_ADMIN}'|" \
        -e "s|WORDPRESS_DB_PASSWORD|'${WORDPRESS_DB_ADMIN_PASS}'|" \
        -e "s|WORDPRESS_DB_HOST|'${WORDPRESS_DB_HOST}'|" /var/www/html/wordpress/wp-config.php

#-------------------------------------------------------------------------------------------
# Installing wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/html/wordpress
/usr/local/bin/wp core install --allow-root --url=${URL} \
                                --title="Inception" --admin_user=${WORDPRESS_DB_ADMIN} \
                                --admin_password=${WORDPRESS_DB_ADMIN_PASS} \
                                --admin_email=${WORDPRESS_USER_EMAIL}


#-------------------------------------------------------------------------------------------
wget "https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1.php" \
    -O /var/www/html/wordpress/adminer.php

#-------------------------------------------------------------------------------------------
echo -e "\033c"

printf "\033[33m———————————————————————————————————————————————————————————————————————\033[0m\n"
printf "\033[32m❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮❮ \033[35m\033[1m\033[3mInception is ready now\033[0m \033[32m❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯❯\033[0m\n"
printf "\033[33m———————————————————————————————————————————————————————————————————————\033[0m\n"

#-------------------------------------------------------------------------------------------
php-fpm7.4 -F