FROM davask/d-apache-letsencrypt:2.4-d9.0
MAINTAINER davask <admin@davask.com>
USER root
LABEL dwl.app.language="php7.3"

ENV DWL_PHP_VERSION 7.0
ENV DWL_PHP_DATETIMEZONE Europe/Paris


RUN sed -i 's|^deb http://deb.debian.org/debian stretch main|deb http://deb.debian.org/debian stretch main contrib non-free|g' /etc/apt/sources.list; \
sed -i 's|^deb http://deb.debian.org/debian stretch-updates main|deb http://deb.debian.org/debian stretch-updates main contrib non-free|g' /etc/apt/sources.list; \
sed -i 's|^deb http://deb.debian.org/debian stretch/updates main|deb http://deb.debian.org/debian stretch/updates main contrib non-free|g' /etc/apt/sources.list; \
echo 'deb http://packages.dotdeb.org stretch all' >> /etc/apt/sources.list; \
echo 'deb-src http://packages.dotdeb.org stretch all' >> /etc/apt/sources.list; \
echo 'deb http://deb.debian.org/debian stretch main' >> /etc/apt/sources.list; \
wget https://www.dotdeb.org/dotdeb.gpg -O /tmp/dotdeb.gpg; \
apt-key add /tmp/dotdeb.gpg; \
rm /tmp/dotdeb.gpg;

# Update packages
RUN apt-get update && apt-get install -y \
php7.3 \
php7.3-fpm \
php7.3-mcrypt \
php7.3-mysqlnd \
php7.3-gd \
php7.3-curl \
php7.3-memcached \
php7.3-cli \
php7.3-readline \
php7.3-mysqlnd \
php7.3-json \
php7.3-intl \
php7.3-common \
php7.3-xml \
php7.3-opcache \
libssl1.1 \
libapache2-mod-php7.3 \
libapache2-mod-fastcgi \
memcached

RUN a2enmod actions fastcgi alias proxy_fcgi setenvif
RUN a2enconf php7.3-fpm

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
