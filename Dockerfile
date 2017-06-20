FROM davask/d-apache-letsencrypt:2.4-d8.8
MAINTAINER davask <docker@davaskweblimited.com>
USER root
LABEL dwl.app.language="php5.6"

ENV DWL_PHP_VERSION 5.6
ENV DWL_PHP_DATETIMEZONE Europe/Paris

# Update packages
RUN apt-get update && apt-get install -y php5 php5-mcrypt php5-mysql php5-gd php5-curl php5-memcached php5-cli php5-readline php5-mysqlnd php5-json php5-intl libapache2-mod-php5 memcached

# sendmail required to use php mail()
RUN apt-get install -y sendmail-bin sendmail
RUN apt-get autoremove -y
RUN rm -rf /var/lib/apt/lists/*

COPY ./build/dwl/php.sh /dwl/php.sh
COPY ./build/dwl/sendmail.sh /dwl/sendmail.sh
COPY ./build/dwl/init.sh /dwl/init.sh
USER admin

