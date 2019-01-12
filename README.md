# ubuntu_-_lamp-kubuntu_desktop-wordpress-ssl
Shell Script for Auto installation of LAMP(Apache,MySQL,Php),PhpMyAdmin,Kubuntu Remote Desktop,Wordpress,SSL

This is a Shell Script(Bash) with & without UI(user interface) to automatically install all above Ubuntu packages for 18.04/Bionic version

If you are using a older verion of Ubuntu like 16.04 or 14.04
Then Remote Desktop(XRDP) facility would not work for you.

## Optional
One can change Default PhpMyAdmin & MySQL password to his/her own choice.

Default MySQL password is : mysql_PASSWORD
And
Default PhpMyAdmin password is : phpmyadmin_PASSWORD

COMMAND TO CHNAGE DEFAULT PASSWORDS:

sudo sed -i 's/phpmyadmin_PASSWORD/NewPassword/g' mediabots_ui.sh

sudo sed -i 's/mysql_PASSWORD/NewPassword/g' mediabots_ui.sh

Run them before running the Script.

## How to Run the Script
wget https://raw.githubusercontent.com/mediabots/ubuntu_-_lamp-kubuntu_desktop-wordpress-ssl/92c6e8cd399ac48c0cc486103e7880cbcaaae3ed/mediabots_ui.sh

chmod +x mediabots_ui.sh

./mediabots_ui.sh

## Security
Since this script would pass your MySQL & PhpMyAdmin password throough command lines

So it is a good practice to change those password after processing the script.

Just go to http://SITE_IP_OR_URL/phpmyadmin and login with default/chosen passwords.

__MySQL user id is root

__PhpMyAdmin user id phpmyadmin

After logged into phpmyadin, click on "user accounts". Then click on "Edit privileges" link from Action column corresponding to User name root & phpmyadmin (one by one). After that click on Change password, put a secure password. Finally click on 'Go' button.

All set :)








