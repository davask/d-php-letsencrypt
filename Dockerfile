FROM davask/d-apache-letsencrypt:2.4-u14.04
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.app.language="php5.6"

ENV DWL_PHP_VERSION 5.6
ENV DWL_PHP_DATETIMEZONE Europe/Paris

# Update packages
RUN apt-get update && apt-get install -y \
php5.6 \
php5.6-fpm \
php5.6-mcrypt \
php5.6-mysqlnd \
php5.6-gd \
php5.6-curl \
php5.6-memcached \
php5.6-cli \
php5.6-readline \
php5.6-mysqlnd \
php5.6-json \
php5.6-intl \
libapache2-mod-php5.6 \
memcached \
sendmail-bin \
sendmail

RUN apt-get upgrade -y && \
apt-get autoremove -y && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN chmod +x /dwl/init.sh && chown root:sudo -R /dwl
USER admin
