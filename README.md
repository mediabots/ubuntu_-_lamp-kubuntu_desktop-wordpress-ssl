# ubuntu_-_lamp-kubuntu_desktop-wordpress-ssl
Shell Script for Auto installation of LAMP(Apache,MySQL,Php),PhpMyAdmin,Kubuntu Remote Desktop,Wordpress,SSL

This is a Shell Script(Bash) with & without UI(user interface) to automatically install all above packages for Ubuntu 18.04/Bionic OS.

If you are using an older version of Ubuntu like 14.04 or 16.04
Then Remote Desktop(XRDP) facility would not work for you.

---

## Requirements
A SSH client such as putty

A VPS or Dedicated server with Ubuntu 18.04(preferred) OS Installed

Either should have acces of root user OR run with su(super user) 

---

## Optional
One can change Default PhpMyAdmin & MySQL password to his/her own choice.

Default MySQL password is : mysql_PASSWORD
And
Default PhpMyAdmin password is : phpmyadmin_PASSWORD

COMMAND TO CHNAGE DEFAULT PASSWORDS:

`sudo sed -i 's/phpmyadmin_PASSWORD/NewPassword/g' mediabots_ui.sh`

`sudo sed -i 's/mysql_PASSWORD/NewPassword/g' mediabots_ui.sh`

Run them before running the Script.

___

## How to Run the Script

`su`

`wget https://raw.githubusercontent.com/mediabots/ubuntu_-_lamp-kubuntu_desktop-wordpress-ssl/92c6e8cd399ac48c0cc486103e7880cbcaaae3ed/mediabots_ui.sh`

`chmod +x mediabots_ui.sh`

`./mediabots_ui.sh`

If you opt for Kubuntu-Desktop installtion, then it would take around 1 hr 15 mins to complete all process.

Otherwise, it would take around 10 minutes only.

***

## Security
Since this script would pass your MySQL & PhpMyAdmin password throough command lines

So it is a good practice to change those password after processing the script.

Just go to http://SITE_IP_OR_URL/phpmyadmin and login with default/chosen passwords.

>MySQL user id is root

>PhpMyAdmin user id is phpmyadmin

After logged into phpmyadin, click on "user accounts". Then click on "Edit privileges" link from Action column corresponding to User name root & phpmyadmin (one by one). After that click on Change password, put a secure password. Finally click on 'Go' button.

All set :)

## Demo Video
coming soon
