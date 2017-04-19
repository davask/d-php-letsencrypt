#! /bin/bash
if [ -f /etc/php/${DWL_PHP_VERSION}/apache2/php.ini ]; then
    sed -i "s|;date.timezone =|date.timezone = ${DWL_PHP_DATETIMEZONE}|g" /etc/php/${DWL_PHP_VERSION}/apache2/php.ini;
fi
if [ -f /etc/php/${DWL_PHP_VERSION}/cli/php.ini ]; then
    sed -i "s|;date.timezone =|date.timezone = ${DWL_PHP_DATETIMEZONE}|g" /etc/php/${DWL_PHP_VERSION}/cli/php.ini;
fi
