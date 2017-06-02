#! /bin/bash
if [ -f /etc/php/${DWL_PHP_VERSION}/apache2/php.ini ]; then
    sudo sed -i "s|;date.timezone =|date.timezone = ${DWL_PHP_DATETIMEZONE}|g" /etc/php/${DWL_PHP_VERSION}/apache2/php.ini;
    # src: http://symfony.com/doc/current/performance.html
    sudo sed -i "s|;opcache.max_accelerated_files=2000|opcache.max_accelerated_files=100000|g" /etc/php/${DWL_PHP_VERSION}/apache2/php.ini;
    sudo sed -i "s|;realpath_cache_size = 16k|realpath_cache_size = 4096k|g" /etc/php/${DWL_PHP_VERSION}/apache2/php.ini;
    sudo sed -i "s|;realpath_cache_ttl = 120|realpath_cache_ttl = 600|g" /etc/php/${DWL_PHP_VERSION}/apache2/php.ini;
fi
if [ -f /etc/php/${DWL_PHP_VERSION}/cli/php.ini ]; then
    sudo sed -i "s|;date.timezone =|date.timezone = ${DWL_PHP_DATETIMEZONE}|g" /etc/php/${DWL_PHP_VERSION}/cli/php.ini;
    sudo sed -i "s|;opcache.max_accelerated_files=2000|opcache.max_accelerated_files=100000|g" /etc/php/${DWL_PHP_VERSION}/cli/php.ini;
    sudo sed -i "s|;realpath_cache_size = 16k|realpath_cache_size = 4096k|g" /etc/php/${DWL_PHP_VERSION}/cli/php.ini;
    sudo sed -i "s|;realpath_cache_ttl = 120|realpath_cache_ttl = 600|g" /etc/php/${DWL_PHP_VERSION}/cli/php.ini;
fi
