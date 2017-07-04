FROM davask/d-apache-letsencrypt:2.4-u16.04
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.app.language="php5.6"

ENV DWL_PHP_VERSION 5.6
ENV DWL_PHP_DATETIMEZONE Europe/Paris

RUN sed -i 's|^deb http://archive.ubuntu.com/ubuntu/ xenial main restricted|deb http://archive.ubuntu.com/ubuntu/ xenial main restricted multiverse|g' /etc/apt/sources.list; \
sed -i 's|^deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted|deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted multiverse|g' /etc/apt/sources.list; \
sed -i 's|^deb http://archive.ubuntu.com/ubuntu/ xenial-security main restricted|deb http://archive.ubuntu.com/ubuntu/ xenial-security main restricted multiverse|g' /etc/apt/sources.list

COPY ./build/etc/apache2/conf-available/php5-fpm.conf /etc/apache2/conf-available/

RUN add-apt-repository ppa:ondrej/php

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
libapache2-mod-fastcgi \
memcached

RUN a2enmod actions fastcgi alias proxy_fcgi setenvif
RUN a2enconf php5.6-fpm

RUN apt-get install -y \
sendmail-bin \
sendmail

RUN echo "include(`/etc/mail/tls/starttls.m4')dnl" | tee -a /etc/mail/sendmail.mc \
echo "include(`/etc/mail/tls/starttls.m4')dnl" | tee -a /etc/mail/submit.mc \
sendmailconfig

RUN apt-get upgrade -y && \
apt-get autoremove -y && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./build/dwl/php.sh \
./build/dwl/init.sh \
/dwl/

CMD ["/dwl/init.sh && service sendmail start && apachectl -k graceful && /bin/bash"]

RUN chmod +x /dwl/init.sh && chown root:sudo -R /dwl
USER admin
