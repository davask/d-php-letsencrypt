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
RUN apt-get update

RUN apt-get install -y php${PHP_VERSION:0:1}
RUN apt-get install -y php${PHP_VERSION:0:1}-mcrypt
RUN apt-get install -y php${PHP_VERSION:0:1}-mysql
RUN apt-get install -y php${PHP_VERSION:0:1}-gd
RUN apt-get install -y php${PHP_VERSION:0:1}-curl
RUN apt-get install -y php${PHP_VERSION:0:1}-memcached
RUN apt-get install -y php${PHP_VERSION:0:1}-cli
# RUN apt-get install -y php${PHP_VERSION:0:1}-mbstring
RUN apt-get install -y php${PHP_VERSION:0:1}-readline
RUN apt-get install -y php${PHP_VERSION:0:1}-mysqlnd
RUN apt-get install -y php${PHP_VERSION:0:1}-json
# RUN apt-get install -y php${PHP_VERSION:0:1}-xsl
# RUN apt-get install -y php${PHP_VERSION:0:1}-xml
RUN apt-get install -y php${PHP_VERSION:0:1}-intl
RUN apt-get install -y libapache2-mod-php${PHP_VERSION:0:1}
RUN apt-get install -y memcached

# sendmail required to use php mail()
RUN apt-get install -y sendmail-bin sendmail
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*

COPY ./build/dwl/php.sh /dwl/php.sh
COPY ./build/dwl/sendmail.sh /dwl/sendmail.sh
COPY ./build/dwl/init.sh /dwl/init.sh
" >> ${rootDir}/Dockerfile

echo "Dockerfile generated with letsencrypt";
