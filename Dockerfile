FROM debian:buster

# Install
RUN apt-get -y update && apt-get -y upgrade && apt-get install -y apt-utils
RUN apt-get -y install mariadb-server
RUN apt-get -y install	wget \
 						nginx \
						openssl \
 						wordpress
RUN apt-get -y install php7.3 php7.3-fpm php-mysql php-fpm php-pdo php-gd php-cli php-mbstring

# WordPress
RUN mv usr/share/wordpress /var/www/html/wordpress
COPY ./srcs/wp-config.php /var/www/html/wordpress
RUN rm -rf /var/www/html/wordpress/wp-config-sample.php

# PhpMyAdmin
RUN wget https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz
RUN tar -xvzf phpMyAdmin-5.0.4-all-languages.tar.gz
RUN mv phpMyAdmin-5.0.4-all-languages /var/www/html/phpmyadmin
RUN rm -rf phpMyAdmin-5.0.4-all-languages.tar.gz
COPY ./srcs/config.inc.php /var/www/html/phpmyadmin
RUN rm -rf /var/www/html/phpmyadmin/config.sample.inc.php

# Nginx
RUN rm -rf ./etc/nginx/sites-available/default
RUN rm -rf ./etc/nginx/sites-enabled/default
COPY ./srcs/nginx.conf ./etc/nginx/sites-available
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf

# Bash
COPY ./srcs/run.sh .
COPY ./srcs/autoindex.sh .

EXPOSE 80 443
ENTRYPOINT /bin/bash run.sh
