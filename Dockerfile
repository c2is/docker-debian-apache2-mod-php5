FROM debian:jessie

MAINTAINER André Cianfarani <a.cianfarani@c2is.fr>

RUN apt-get update && apt-get install -y apache2 php5 libapache2-mod-php5 php5-mysql php5-curl php5-gd php5-intl php5-mcrypt php5-xmlrpc
RUN apt-get install -y ssmtp
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
RUN mkdir /etc/apache2/ssl
RUN a2enmod rewrite
RUN a2enmod ssl
RUN a2enmod headers

ADD ports.conf /etc/apache2/ports.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod 777 /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

RUN ln -s /etc/apache2/sites-available/vhost-website.conf /etc/apache2/sites-enabled/vhost-website.conf
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
EXPOSE 80
EXPOSE 443
