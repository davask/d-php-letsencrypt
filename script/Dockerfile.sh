#/usr/bin/env bash

branch=${1};
parentBranch=${2};
rootDir=${3};
buildDir=${4};

##############
# Dockerfile #
##############

echo "FROM davask/d-apache-letsencrypt:${parentBranch}
MAINTAINER davask <docker@davaskweblimited.com>
LABEL dwl.app.language=\"php${PHP_VERSION}\"" > ${rootDir}/Dockerfile
echo "
ENV DWL_PHP_VERSION ${PHP_VERSION}
ENV DWL_PHP_DATETIMEZONE Europe/Paris

# Update packages
RUN apt-get update

# INSTALL PHP5.5.9 - see http://packages.ubuntu.com/search?keywords=php5
# RUN apt-get install -y php5
# INSTALL PHP5.6.23 - https://launchpad.net/~ondrej/+archive/ubuntu/php
RUN LC_ALL=C.UTF-8 add-apt-repository ppa:ondrej/php
# INSTALL PHP7.0.15 - see http://packages.ubuntu.com/search?keywords=php7
# RUN apt-get install -y php7

RUN apt-get update
RUN apt-get install -y php${PHP_VERSION}
RUN apt-get install -y php${PHP_VERSION}-mcrypt
RUN apt-get install -y php${PHP_VERSION}-mbstring
RUN apt-get install -y php${PHP_VERSION}-mysql
RUN apt-get install -y php${PHP_VERSION}-gd
RUN apt-get install -y php${PHP_VERSION}-curl
RUN apt-get install -y php${PHP_VERSION}-memcached
RUN apt-get install -y php${PHP_VERSION}-cli
RUN apt-get install -y php${PHP_VERSION}-readline
RUN apt-get install -y php${PHP_VERSION}-mysqlnd
RUN apt-get install -y php${PHP_VERSION}-json
RUN apt-get install -y php${PHP_VERSION}-xsl
RUN apt-get install -y php${PHP_VERSION}-xml
RUN apt-get install -y php${PHP_VERSION}-intl
RUN apt-get install -y libapache2-mod-php${PHP_VERSION}
RUN apt-get install -y memcached

# sendmail required to use php mail()
RUN apt-get install -y sendmail
RUN rm -rf /var/lib/apt/lists/*

COPY ./build/dwl/php.sh /dwl/php.sh
COPY ./build/dwl/sendmail.sh /dwl/sendmail.sh
COPY ./build/dwl/init.sh /dwl/init.sh
" >> ${rootDir}/Dockerfile

echo "Dockerfile generated with letsencrypt";
