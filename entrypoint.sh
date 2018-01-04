#!/bin/bash
set -e
rm /etc/apache2/sites-available/vhost-website.conf

if [ -z "$WEBSITE_HOST" ]; then
	WEBSITE_HOST="website.docker"
fi
if [ "$SYMFONY_VHOST_COMPLIANT" == "yes" ]; then
	SUFFIX="/web"
fi

cat <<EOF >> /etc/apache2/sites-available/vhost-website.conf
<VirtualHost *:80>
        ServerName $WEBSITE_HOST
        ServerAlias *.$WEBSITE_HOST
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/website$SUFFIX

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        <Directory /var/www/website$SUFFIX>
          Require all granted	
          Options -Indexes +FollowSymLinks -MultiViews
          Order allow,deny
          allow from all
	      AllowOverride All
        </Directory>
</VirtualHost>
EOF

exec "$@"
