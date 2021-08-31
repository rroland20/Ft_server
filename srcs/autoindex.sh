#!/bin/sh

if [ $1 == "on" ]; then
	sed -i 's/autoindex off/autoindex on/' ./etc/nginx/sites-available/nginx.conf
fi
if [ $1 == "off" ]; then
	sed -i 's/autoindex on/autoindex off/' ./etc/nginx/sites-available/nginx.conf
fi
if [ $1 != "on" -a $1 != "off" ]; then
	echo "Wrong answer"
else
	nginx -s reload
fi
