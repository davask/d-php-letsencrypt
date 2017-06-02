FROM davask/d-apache-letsencrypt:2.4-d8.8
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.app.language="php5.6"

ENV DWL_PHP_VERSION 5.6
ENV DWL_PHP_DATETIMEZONE Europe/Paris

# Update packages
RUN apt-get update

RUN apt-get install -y php5
RUN apt-get install -y php5-mcrypt
RUN apt-get install -y php5-mysql
RUN apt-get install -y php5-gd
RUN apt-get install -y php5-curl
RUN apt-get install -y php5-memcached
RUN apt-get install -y php5-cli
# RUN apt-get install -y php5-mbstring
RUN apt-get install -y php5-readline
RUN apt-get install -y php5-mysqlnd
RUN apt-get install -y php5-json
# RUN apt-get install -y php5-xsl
# RUN apt-get install -y php5-xml
RUN apt-get install -y php5-intl
RUN apt-get install -y libapache2-mod-php5
RUN apt-get install -y memcached

# sendmail required to use php mail()
RUN apt-get install -y sendmail
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*

COPY ./build/dwl/php.sh /dwl/php.sh
COPY ./build/dwl/sendmail.sh /dwl/sendmail.sh
COPY ./build/dwl/init.sh /dwl/init.sh

