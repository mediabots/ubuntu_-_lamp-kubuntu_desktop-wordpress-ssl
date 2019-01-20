# ubuntu_-_lamp-kubuntu_desktop-wordpress-ssl
A Shell Script to Auto install LAMP(Apache,MySQL,Php),PhpMyAdmin,Kubuntu Desktop,Wine,Wordpress,SSL Certificate

This is a Shell Script (Bash) with & without UI (user interface) to automatically install all above packages for Ubuntu 18.04/Bionic O.S.

If you are using an older version of Ubuntu like 16.04 or 14.04, then Remote Desktop(XRDP) facility would not work for you.

With Kubuntu-desktop, the script will also install WINE package to run Windows apps on your Linux system.

Letsencrypt.org verifies SSL and initially, it would provide a 3-month Certificate. The certificate would be auto-renewed after every 60 days by "Certbot" app, which will also be installed in your system :)

---

## Requirements
A SSH client such as putty

A VPS or Dedicated server with Ubuntu 18.04(preferred) OS Installed.

Either should have access of root user OR run with su (super user) 

---

## Optional
After Downloading "mediabots_ui.sh" file via wget, one can change Default PhpMyAdmin & MySQL password to his/her own choice.

Default MySQL user 'root' password is: mysql_PASSWORD
And
Default 'phpmyadmin' password is: phpmyadmin_PASSWORD

COMMAND TO CHNAGE DEFAULT PASSWORDS:

`sudo sed -i 's/phpmyadmin_PASSWORD/NewPassword/g' mediabots_ui.sh`

`sudo sed -i 's/mysql_PASSWORD/NewPassword/g' mediabots_ui.sh`

Run them before running the Script.

___

## How to Run the Script

Just run below four commands one after another :

`su`

`wget https://raw.githubusercontent.com/mediabots/ubuntu_-_lamp-kubuntu_desktop-wordpress-ssl/master/mediabots_ui.sh`

`chmod +x mediabots_ui.sh`

`./mediabots_ui.sh`

If you opt for Kubuntu-Desktop installation, then it would take around 1 hr 15 mins to complete all the process.

Otherwise, it would take more or less 10 minutes.

***

## Security
Since this script would pass your MySQL & PhpMyAdmin password through command lines

So it is a good practice to change those password after processing the script.

Just go to http://SITE_IP_OR_URL/phpmyadmin and log in with default/chosen passwords.

>MySQL user id is root

>PhpMyAdmin user id is phpmyadmin

After logged into PHPMyAdmin, click on "user accounts". Then click on "Edit privileges" link from Action column corresponding to User name root & phpmyadmin (one by one). After that click on "Change password", put a secure password. Finally, click on the 'Go' button.

All set :)

## Demo Video

<a href="http://www.youtube.com/watch?feature=player_embedded&v=LsI1Luq6X4Q" target="_blank"><img src="http://img.youtube.com/vi/LsI1Luq6X4Q/0.jpg" 
alt="Auto installation of LAMP(Apache,MySQL,Php),PhpMyAdmin,Kubuntu Remote Desktop,Wordpress,SSL Certificate" width="480" height="360" border="10" /></a>

## Conclusion

The script would take care of all common issues of Wordpress installation, such as Directory & User Permission, Redirection/Rewrite rules, .htaccess, etc.

The script would create an individual directory for each domain name such as/var/www/html/YourDomainName

Moreover, it would also create an individual host file for each domain name such as/etc/apache2/sites-available/YourDomainName.conf

That offers you to add the unlimited number of websites in your Server.

The Certbot would automatically renew SSL for your domain name. So you don't have to worry about that thing too.

## Reference

askubuntu.com, stackexchange.com, stackoverflow.com, ubuntuforums.com, Lynda.com,eff.org, tecmint.com
