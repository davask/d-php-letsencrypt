#/usr/bin/env bash

branch=${1};
parentBranch=${2};
rootDir=${3};
buildDir=${4};

#############
# README.md #
#############

echo "# dockerfile

see [FROM IMAGE README.md](https://github.com/davask/d-apache2)

### PHP ${PHP_VERSION} activation

#### comment

- to avoid init error all conf file in /etc/apache2/sites-available have to be in the format of sub.domain.ext.conf like docker.davaskweblimited.com.conf

- On start all *.conf in /etc/apache2/sites-available are enabled

## LABEL

> dwl.app.language=\"php${PHP_VERSION}\"
" > ${rootDir}/README.md

echo "README.md generated with php:${branch}";
