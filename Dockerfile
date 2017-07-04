FROM davask/d-apache-letsencrypt:2.4-d8.8
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.app.language="php5.6"

ENV DWL_PHP_VERSION 5.6
ENV DWL_PHP_DATETIMEZONE Europe/Paris

RUN echo 'deb http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list; \
echo 'deb-src http://packages.dotdeb.org jessie all' >> /etc/apt/sources.list; \
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

CMD ["/dwl/init.sh && service sendmail start && apachectl -k graceful && /bin/bash"]

RUN chmod +x /dwl/init.sh && chown root:sudo -R /dwl
USER admin
