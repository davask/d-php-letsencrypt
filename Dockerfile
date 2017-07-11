FROM davask/d-apache-letsencrypt:2.4-d8.8
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.app.language="php5.6"

ENV DWL_PHP_VERSION 5.6
ENV DWL_PHP_DATETIMEZONE Europe/Paris

COPY ./build/etc/apache2/conf-available/php5-fpm.conf \
/etc/apache2/conf-available/


RUN sed -i 's|^deb http://deb.debian.org/debian jessie main|deb http://deb.debian.org/debian jessie main contrib non-free|g' /etc/apt/sources.list; \
sed -i 's|^deb http://deb.debian.org/debian jessie-updates main|deb http://deb.debian.org/debian jessie-updates main contrib non-free|g' /etc/apt/sources.list; \
sed -i 's|^deb http://deb.debian.org/debian jessie/updates main|deb http://deb.debian.org/debian jessie/updates main contrib non-free|g' /etc/apt/sources.list; \
echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list; \
echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list; \
echo 'deb http://deb.debian.org/debian stretch main' >> /etc/apt/sources.list; \
wget https://www.dotdeb.org/dotdeb.gpg -O /tmp/dotdeb.gpg; \
apt-key add /tmp/dotdeb.gpg; \
rm /tmp/dotdeb.gpg;

# Update packages
RUN apt-get update && apt-get install -y \
php5 \
php5-fpm \
php5-mcrypt \
php5-mysqlnd \
php5-gd \
php5-curl \
php5-memcached \
php5-cli \
php5-readline \
php5-mysqlnd \
php5-json \
php5-intl \
php5-common \
libssl1.1 \
libapache2-mod-php5 \
libapache2-mod-fastcgi \
memcached

RUN a2enmod actions fastcgi alias proxy_fcgi setenvif
RUN a2enconf php5-fpm

RUN apt-get install -y \
sendmail-bin \
sendmail

RUN apt-get upgrade -y && \
apt-get autoremove -y && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./build/dwl/php.sh \
./build/dwl/init.sh \
/dwl/

RUN chmod +x /dwl/init.sh && chown root:sudo -R /dwl
USER admin
