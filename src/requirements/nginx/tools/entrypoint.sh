#!/bin/sh

mkdir -p /etc/nginx/ssl/;

openssl req -x509 -nodes -days 365 \
	-subj "/C=UE/ST=AD/O=42, Inc./CN=gabdoush.42.fr" \
	-addext "subjectAltName=DNS:gabdoush.42.fr" \
	-newkey rsa:2048 \
	-keyout $PRIVATE_KEY \
	-out $CERTIFICATE;

sed -i -e "s|CERTIFICATE|${CERTIFICATE}|" \
		-e "s|PRIVATE_KEY|${PRIVATE_KEY}|" /etc/nginx/sites-available/inception.conf

nginx -g 'daemon off;'