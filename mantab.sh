#!/bin/sh

#######################################
# Bash script to install an AMP stack and PHPMyAdmin plus tweaks. For Debian based systems.
# In case of any errors (e.g. MySQL) just re-run the script. Nothing will be re-installed except for the packages with errors.
#######################################

#COLORS
# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan

# Update packages and Upgrade system
echo -e "$Cyan \n Updating System.. $Color_Off"
sudo apt-add-repository ppa:ondrej/php -y
sudo apt-get update -y && sudo apt-get upgrade -y

## Install AMP
echo -e "$Cyan \n Installing Apache2 $Color_Off"
sudo apt-get install apache2 -y

echo -e "$Cyan \n Installing PHP7.0 & Requirements $Color_Off"
sudo apt-get install php7.2 libapache2-mod-php7.2 php7.2-mysql php7.2-curl php-memcache php7.2-opcache php-apcu -y

echo -e "$Cyan \n Installing MariaDB $Color_Off"
sudo apt-get install mariadb-server mariadb-client -y
mysql_secure_installation

echo -e "$Cyan \n Installing phpMyAdmin $Color_Off"
sudo apt-get install phpmyadmin -y

echo -e "$Cyan \n Installing SSL Support $Color_Off"
a2enmod ssl
a2ensite default-ssl

echo -e "$Cyan \n Verifying installs$Color_Off"
sudo apt-get install apache2 php7.2 libapache2-mod-php7.2 php7.2-mysql php7.2-curl php-memcache php7.2-opcache php-apcu php-pear php-gd memcached mariadb-server mariadb-client phpmyadmin -y

## TWEAKS and Settings
# Permissions
echo -e "$Cyan \n Permissions for /var/www $Color_Off"
sudo chown -R www-data:www-data /var/www
echo -e "$Green \n Permissions have been set $Color_Off"

# Enabling Mod Rewrite, required for WordPress permalinks and .htaccess files
echo -e "$Cyan \n Enabling Modules $Color_Off"
sudo a2enmod rewrite
sudo php5enmod mcrypt

# Restart Apache
echo -e "$Cyan \n Restarting Apache $Color_Off"
sudo service apache2 restart
