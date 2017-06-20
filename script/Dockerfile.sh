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
USER root
LABEL dwl.app.language=\"php${PHP_VERSION}\"" > ${rootDir}/Dockerfile
echo "
ENV DWL_PHP_VERSION ${PHP_VERSION}
ENV DWL_PHP_DATETIMEZONE Europe/Paris

# Update packages
RUN apt-get update && apt-get install -y \
php${PHP_VERSION:0:1} \
php${PHP_VERSION:0:1}-mcrypt \
php${PHP_VERSION:0:1}-mysqlnd \
php${PHP_VERSION:0:1}-gd \
php${PHP_VERSION:0:1}-curl \
php${PHP_VERSION:0:1}-memcached \
php${PHP_VERSION:0:1}-cli \
php${PHP_VERSION:0:1}-readline \
php${PHP_VERSION:0:1}-mysqlnd \
php${PHP_VERSION:0:1}-json \
php${PHP_VERSION:0:1}-intl \
libapache2-mod-php${PHP_VERSION:0:1} \
memcached

# sendmail required to use php mail()
RUN apt-get install -y sendmail-bin sendmail
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*

COPY ./build/dwl/php.sh /dwl/php.sh
COPY ./build/dwl/sendmail.sh /dwl/sendmail.sh
COPY ./build/dwl/init.sh /dwl/init.sh
USER admin
" >> ${rootDir}/Dockerfile

echo "Dockerfile generated with letsencrypt";
