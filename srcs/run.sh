#!/bin/bash

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
			-keyout /usr/lib/ssl/certs/rroland.key \
			-out /usr/lib/ssl/certs/rroland.crt \
			-subj "/C=RU/ST=Kazan/L=Kazan/O=no/OU=no/CN=rroland" 
chmod -R 777 /usr/lib/ssl/certs/rroland*

service php7.3-fpm start
service nginx start
service mysql start

echo "CREATE DATABASE wordpress;"| mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost' WITH GRANT OPTION;"| mysql -u root --skip-password
echo "FLUSH PRIVILEGES;"| mysql -u root --skip-password
echo "update mysql.user set plugin='' where user='root';"| mysql -u root --skip-password

rm -rf /var/www/html/index.html
rm -rf /var/www/html/index.nginx-debian.html

bash
