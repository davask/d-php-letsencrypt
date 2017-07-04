FROM davask/d-apache-letsencrypt:2.4-u14.04
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.app.language="php5.6"

ENV DWL_PHP_VERSION 5.6
ENV DWL_PHP_DATETIMEZONE Europe/Paris

RUN sed -i 's|^deb http://archive.ubuntu.com/ubuntu/ trusty main restricted|deb http://archive.ubuntu.com/ubuntu/ trusty main restricted multiverse|g' /etc/apt/sources.list; \
sed -i 's|^deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted|deb http://archive.ubuntu.com/ubuntu/ trusty-updates main restricted multiverse|g' /etc/apt/sources.list; \
sed -i 's|^deb http://archive.ubuntu.com/ubuntu/ trusty-security main restricted|deb http://archive.ubuntu.com/ubuntu/ trusty-security main restricted multiverse|g' /etc/apt/sources.list;
COPY ./build/etc/apache2/conf-available/php5-fpm.conf /etc/apache2/conf-available/

RUN add-apt-repository ppa:ondrej/php;

RUN apt-get upgrade -y && \
apt-get autoremove -y && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN chmod +x /dwl/init.sh && chown root:sudo -R /dwl
USER admin
