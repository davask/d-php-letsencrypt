FROM davask/d-apache-letsencrypt:2.4-u16.04
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.app.language="php7.0"

ENV DWL_PHP_VERSION 7.0
ENV DWL_PHP_DATETIMEZONE Europe/Paris

RUN sed -i 's|^deb http://archive.ubuntu.com/ubuntu/ xenial main restricted|deb http://archive.ubuntu.com/ubuntu/ xenial main restricted multiverse|g' /etc/apt/sources.list; \
sed -i 's|^deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted|deb http://archive.ubuntu.com/ubuntu/ xenial-updates main restricted multiverse|g' /etc/apt/sources.list; \
sed -i 's|^deb http://archive.ubuntu.com/ubuntu/ xenial-security main restricted|deb http://archive.ubuntu.com/ubuntu/ xenial-security main restricted multiverse|g' /etc/apt/sources.list


RUN add-apt-repository ppa:ondrej/php

# Update packages
RUN apt-get update && apt-get install -y \
php7.0 \
php7.0-fpm \
php7.0-mcrypt \
php7.0-mysqlnd \
php7.0-gd \
php7.0-curl \
php7.0-memcached \
php7.0-cli \
php7.0-readline \
php7.0-mysqlnd \
php7.0-json \
php7.0-intl \
libapache2-mod-php7.0 \
libapache2-mod-fastcgi \
memcached

RUN a2enmod actions fastcgi alias proxy_fcgi setenvif
RUN a2enconf php7.0-fpm

RUN apt-get install -y \
sendmail-bin \
sendmail

RUN echo 'include(`/etc/mail/tls/starttls.m4'\'')dnl' | tee -a /etc/mail/sendmail.mc; \
echo 'include(`/etc/mail/tls/starttls.m4'\'')dnl' | tee -a /etc/mail/submit.mc; \
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
