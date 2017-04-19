FROM davask/d-apache-letsencrypt:2.4-u14.04
MAINTAINER davask <docker@davaskweblimited.com>
LABEL dwl.app.language="php5.6"

ENV DWL_PHP_VERSION 5.6
ENV DWL_PHP_DATETIMEZONE Europe/Paris

# Update packages
RUN apt-get update
RUN apt-get install -y software-properties-common

# INSTALL PHP5.5.9 - see http://packages.ubuntu.com/search?keywords=php5
# RUN apt-get install -y php5
# INSTALL PHP5.6.23 - https://launchpad.net/~ondrej/+archive/ubuntu/php
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
# INSTALL PHP7.0.15 - see http://packages.ubuntu.com/search?keywords=php7
# RUN apt-get install -y php7

RUN apt-get update
RUN apt-get install -y php5.6
RUN apt-get install -y php5.6-mcrypt
RUN apt-get install -y php5.6-mbstring
RUN apt-get install -y php5.6-mysql
RUN apt-get install -y php5.6-gd
RUN apt-get install -y php5.6-curl
RUN apt-get install -y php5.6-memcached
RUN apt-get install -y php5.6-cli
RUN apt-get install -y php5.6-readline
RUN apt-get install -y php5.6-mysqlnd
RUN apt-get install -y php5.6-json
RUN apt-get install -y php5.6-xsl
RUN apt-get install -y php5.6-xml
RUN apt-get install -y php5.6-intl
RUN apt-get install -y libapache2-mod-php5.6
RUN apt-get install -y memcached

# sendmail required to use php mail()
RUN apt-get install -y sendmail
RUN rm -rf /var/lib/apt/lists/*

COPY ./build/dwl/php.sh /dwl/php.sh
COPY ./build/dwl/sendmail.sh /dwl/sendmail.sh
COPY ./build/dwl/init.sh /dwl/init.sh

