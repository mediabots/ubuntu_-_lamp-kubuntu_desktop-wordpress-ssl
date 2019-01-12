# ubuntu_-_lamp-kubuntu_desktop-wordpress-ssl
Shell Script for Auto installation of LAMP(Apache,MySQL,Php),PhpMyAdmin,Kubuntu Remote Desktop,Wordpress,SSL

This is a Shell Script(Bash) with & without UI(user interface) to automatically install all above Ubuntu packages for 18.04/Bionic version

## Optional
One can change Default PhpMyAdmin & MySQL password to his/her own choice.

Default MySQL password is : mysql_PASSWORD
And
Default PhpMyAdmin password is : phpmyadmin_PASSWORD

COMMAND TO CHNAGE DEFAULT PASSWORDS:

sudo sed -i 's/phpmyadmin_PASSWORD/NewPassword/g' mediabots_ui.sh

sudo sed -i 's/mysql_PASSWORD/NewPassword/g' mediabots_ui.sh

USE them before runninf the Script.

## How to Run the Script
wget https://raw.githubusercontent.com/mediabots/ubuntu_-_lamp-kubuntu_desktop-wordpress-ssl/92c6e8cd399ac48c0cc486103e7880cbcaaae3ed/mediabots_ui.sh

chmod +x mediabots_ui.sh

./mediabots_ui.sh




