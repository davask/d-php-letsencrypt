FROM davask/d-apache-letsencrypt:2.4-u14.04
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.app.language="php5.6"

ENV DWL_PHP_VERSION 5.6
ENV DWL_PHP_DATETIMEZONE Europe/Paris

# Update packages
RUN apt-get update && apt-get install -y \
php.6 \
php.6-fpm \
php.6-mcrypt \
php.6-mysqlnd \
php.6-gd \
php.6-curl \
php.6-memcached \
php.6-cli \
php.6-readline \
php.6-mysqlnd \
php.6-json \
php.6-intl \
libapache2-mod-php.6 \
memcached \
sendmail-bin \
sendmail

RUN apt-get upgrade -y && \
apt-get autoremove -y && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN chmod +x /dwl/init.sh && chown root:sudo -R /dwl
USER admin
