#!/bin/bash

#Taking user inputs
host=1
wordpress_installation_=0
read -r -p "[1] Do you want to install Wordpress? (Yes/No) : " wordpress_installation
wordpress_installation=$(echo "$wordpress_installation" | head -c 1)

if [ ! -z $wordpress_installation ] && [ $wordpress_installation = 'Y' -o $wordpress_installation = 'y' ]; then
	wordpress_installation_=1
	echo ".:Advanced Setting:. It is Optional"
	read -r -p "Do you want to setup Wordpress Database? (Yes/No) : " wpdb_choice
	wpdb_choice=$(echo "$wpdb_choice" | head -c 1)
	if [ $wpdb_choice = 'Y' -o $wpdb_choice = 'y' ]; then
		read -r -p " [1.1] Enter Wordpress 'Database Name', you want to create : " wpdb_name
		read -r -p " [1.2] Enter Wordpress 'Database Username', you want to create : " wpdb_user
		read -r -p " [1.3] Enter Wordpress 'Database Password', you want to create : " wpdb_password
	fi
fi

read -r -p "[2] Enter Domain Name (leave Blank,if you don't have any) : " domain
if [ -z $domain ] && [ $wordpress_installation_ -eq 1 ]; then
	domain='wordpress'
	host=0
fi

if [ -z $domain ] && [ $wordpress_installation_ -eq 0 ]; then
	domain='mysite'
	host=0
fi

if [ -z $wpdb_name ]; then wpdb_name='wordpress_DATABASE'; fi
if [ -z $wpdb_user ]; then wpdb_user='wordpress_USER'; fi
if [ -z $wpdb_password ]; then wpdb_password='wordpress_PASSWORD'; fi

echo "[3] Do you want to install Remote Desktop(XRDP)?"
read -r -p " > It would take at least 1 hour to install. (Yes/No) : " xrdp_installtion
xrdp_installtion=$(echo "$xrdp_installtion" | head -c 1)

# Installing sudo
printf "Y\n" | apt install sudo -y

# Updating System
sudo apt-get update
sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
sudo apt-get -y dist-upgrade

if [ $xrdp_installtion = 'Y' -o $xrdp_installtion = 'y' ]; then
	# Installing Kubuntu Desktop & its Dependencies
	sudo apt-get -y install xorg xrdp build-essential tasksel
	sudo DEBIAN_FRONTEND=noninteractive tasksel install kubuntu-desktop
	sudo service xrdp restart

	# Setting Up Kubuntu Desktop
	sudo apt-get -y install nemo gedit
	sudo xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
	sudo apt-get -y purge dolphin kate gwenview
	sudo xdg-mime default gedit.desktop text/plain
	sudo rm -f /*/Desktop/trash.desktop
	sudo rm -f /*/*/Desktop/trash.desktop
	sudo apt-get autoclean
	sudo apt-get autoremove

	# Installing WINE to run Windows Applications
	sudo dpkg --add-architecture i386
	sudo wget -nc https://dl.winehq.org/wine-builds/winehq.key
	sudo apt-key add winehq.key
	sudo apt-add-repository https://dl.winehq.org/wine-builds/ubuntu/
	sudo apt-get update
	sudo apt-get install --install-recommends winehq-devel -y
	sudo apt-get install winetricks -y
fi

# Installing LAMP (Apache Server, MySQL, Php) & Firewall
sudo apt-get -y install apache2 ufw # Apache and Firewall
printf "y\n" | sudo ufw enable
sudo ufw allow 3389 # Allowing remote desktop (xrdp) to Firewall
sudo ufw allow ssh
sudo ufw allow in "Apache Full"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install mysql-server
sudo mysql -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1')"
sudo mysql -e "FLUSH PRIVILEGES"
sudo DEBIAN_FRONTEND=noninteractive apt-get -y install php libapache2-mod-php php-mysql
sudo service apache2 restart
sudo chown -R "$USER":root /var/www

# Preparing PhpMyAdmin installation
sudo apt-get -y install debconf-utils
sudo debconf-set-selections <<<'phpmyadmin phpmyadmin/dbconfig-install boolean true'
sudo debconf-set-selections <<<'phpmyadmin phpmyadmin/app-password-confirm password phpmyadmin_PASSWORD'
sudo debconf-set-selections <<<'phpmyadmin phpmyadmin/mysql/admin-pass password phpmyadmin_PASSWORD'
sudo debconf-set-selections <<<'phpmyadmin phpmyadmin/mysql/app-pass password phpmyadmin_PASSWORD'
sudo debconf-set-selections <<<'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2'

# PhpMyAdmin installation & configuration
sudo DEBIAN_FRONTEND=noninteractive apt-get install -q -y phpmyadmin

sudo mysql -u root <<CMD_EOF
UPDATE mysql.user SET authentication_string=PASSWORD('mysql_PASSWORD') WHERE user='root';
UPDATE mysql.user SET plugin='mysql_native_password' WHERE user='root';
FLUSH PRIVILEGES;
CMD_EOF

sudo echo -en "[mysql]\nuser=root\npassword=mysql_PASSWORD\n" >~/.my.cnf
sudo chmod 0600 ~/.my.cnf

# Preparing Website
mkdir /var/www/html/$domain
sudo touch /var/www/html/$domain/.htaccess
sudo echo -en "<Directory /var/www/html/$domain>\n\tAllowOverride All\n</Directory>" >/etc/apache2/sites-available/$domain.conf
sudo echo -en "\n<VirtualHost *:80>\n\tServerAdmin admin@$domain\n\tServerName $domain\n\tDocumentRoot /var/www/html/$domain\n\tErrorLog ${APACHE_LOG_DIR}/error.log\n\tCustomLog ${APACHE_LOG_DIR}/access.log combined\n</VirtualHost>" >>/etc/apache2/sites-available/$domain.conf
sudo a2ensite $domain.conf
sudo systemctl reload apache2
sudo a2dissite 000-default.conf
sudo systemctl reload apache2
sudo a2enmod rewrite
sudo systemctl restart apache2

if [ $wordpress_installation_ -eq 1 ]; then
	# Creating Wordpress Database
	sudo mysql -u root <<CMD_EOF
CREATE DATABASE $wpdb_name;
GRANT ALL PRIVILEGES ON $wpdb_name.* TO '$wpdb_user'@'localhost' IDENTIFIED BY '$wpdb_password';
FLUSH PRIVILEGES;
CMD_EOF

	# Downloading Wordpress
	wget http://wordpress.org/latest.tar.gz
	tar xzvf latest.tar.gz

	# Installing Wordpress dependencies
	sudo apt-get -y install php-curl php-gd php-mbstring php-xml php-xmlrpc php-soap php-intl php-zip

	# Pre Configuring Wordpress
	sudo cp ./wordpress/wp-config-sample.php ./wordpress/wp-config.php
	sudo sed -i '/put your unique phrase here/d' ./wordpress/wp-config.php # delete matching pattern
	sudo sed -i '$d' ./wordpress/wp-config.php # delete last line
	table_prefix=$(tr </dev/urandom -dc A-Za-z | head -c6)_ || WP_
	sudo sed -i 's/wp_/'$table_prefix'/g' ./wordpress/wp-config.php
	sudo sed -i 's/database_name_here/'$wpdb_name'/g' ./wordpress/wp-config.php
	sudo sed -i 's/username_here/'$wpdb_user'/g' ./wordpress/wp-config.php
	sudo sed -i 's/password_here/'$wpdb_password'/g' ./wordpress/wp-config.php
	# Setting up SALT [ Thanks to @paulwaldmann]
	sudo curl -s https://api.wordpress.org/secret-key/1.1/salt/ > ./wordpress/keys.txt
	keys=($(grep 'define' ./wordpress/keys.txt | cut -f2 -d"'"))
	oldIFS=$IFS
	IFS=$'\n'
	idx=0
	for value in $(grep 'define' ./wordpress/keys.txt | cut -f4 -d"'"); do 
	sudo echo -en "define('${keys[$idx]}', '${value}');\r\n" >> ./wordpress/wp-config.php; 
	idx=$((idx+1))
	done
	IFS=$oldIFS
	sudo echo -en "define('FS_METHOD', 'direct');\r\nrequire_once(ABSPATH . 'wp-settings.php');" >> ./wordpress/wp-config.php; #Update WordPress Directly Without Using FTP
	
	# Installing & Configuring Wordpress
	sudo rsync -avP ./wordpress/ /var/www/html/$domain/
	sudo chown -R www-data:www-data /var/www/html/$domain/
	mkdir /var/www/html/$domain/wp-content/uploads
	sudo chown -R www-data:www-data /var/www/html/$domain/wp-content/uploads
	sudo service apache2 restart
	sudo find /var/www/html/$domain -type d -exec chmod 750 {} \;
	sudo find /var/www/html/$domain -type f -exec chmod 640 {} \;

	# Install Command line interface for WordPress (WP-CLI) [ credit @paulwaldmann]
	curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar >/tmp/wp-cli.phar
	chmod +x /tmp/wp-cli.phar
	mv /tmp/wp-cli.phar /usr/local/bin/wp
fi

# Hiding Server info
sudo sed -i "0,/<\/Directory>/{s/<\/Directory>/<\/Directory>\n<Directory \/var\/www\/html>\n\tOptions -Indexes\n<\/Directory>\n/}" /etc/apache2/apache2.conf
sudo echo -en "ServerSignature off\nServerTokens prod" >> /etc/apache2/apache2.conf
sudo service apache2 restart
#sudo apt-get install libapache2-mod-security2 -y
#sudo mv /etc/modsecurity/modsecurity.conf-recommended /etc/modsecurity/modsecurity.conf
#sudo service apache2 reload
#sudo sed -i "s/SecRuleEngine DetectionOnly/SecRuleEngine On/" /etc/modsecurity/modsecurity.conf
#sudo sed -i "s/SecResponseBodyAccess On/SecResponseBodyAccess Off/" /etc/modsecurity/modsecurity.conf
#sudo sed -i 's/<\/IfModule>/\tSecServerSignature " "\n<\/IfModule>/' /etc/apache2/mods-enabled/security2.conf # whether does it work ,test it after apache2 restart, by curl -I http://IP_Address
#sudo service apache2 restart

# Cleaning Data 
if [ $wordpress_installation_ -eq 1 ]; then
	rm -f /var/www/html/index.html
	rm -rf wordpress
fi
rm -f ~/.my.cnf

# Renabling SSH
sudo /etc/init.d/ssh restart
sudo sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
sudo /etc/init.d/ssh restart
sudo dpkg-reconfigure openssh-server
(
	cd /etc/NetworkManager/dispatcher.d/
	echo sudo /etc/init.d/ssh restart >./10ssh
	chmod 755 ./10ssh
)
sudo systemctl enable ssh.service

# Adding Domain name in Host file
if [ $host -eq 1 ]; then sudo echo -e "$(curl ifconfig.me)\t$domain" >>/etc/hosts; fi

# Installing SSL
if [ $host -eq 1 ]; then
	sudo apt-get -y install software-properties-common
	sudo add-apt-repository ppa:certbot/certbot -y
	sudo apt-get update
	sudo apt-get -y install python-certbot-apache
	echo -e "admin@$domain\nA\n" | sudo DEBIAN_FRONTEND=noninteractive certbot --apache -d $domain
	sudo sed -i 's/<\/VirtualHost>/RewriteEngine on\nRewriteCond %{SERVER_NAME} ='$domain'\nRewriteRule ^ https:\/\/%{SERVER_NAME}%{REQUEST_URI} [END,NE,R=permanent]\n<\/VirtualHost>/g' /etc/apache2/sites-available/$domain.conf
	sudo systemctl restart apache2
fi

#sudo reboot
# now open SITE_URL_or_IP/wp-admin/install.php
# SSL test here https://www.ssllabs.com/ssltest/analyze.html?d=SITE_URL_or_IP
