# ubuntu_-_lamp-kubuntu_desktop-wordpress-ssl
Shell Script for Auto installation of LAMP(Apache,MySQL,Php),PhpMyAdmin,Kubuntu Desktop,Wine,Wordpress,SSL Certificate

This is a Shell Script(Bash) with & without UI(user interface) to automatically install all above packages for Ubuntu 18.04/Bionic O.S.

If you are using an older version of Ubuntu like 16.04 or 14.04. Then Remote Desktop(XRDP) facility would not work for you.

Script will also install WINE package to run Windows apps on your Linux system.

SSL is verified by letsencrypt.org and initially it would provide a 3 month Certificate. Certificate would be auto renewed after every 60 days by "CertBOT" app,which also would be installed in your system :)

---

## Requirements
A SSH client such as putty

A VPS or Dedicated server with Ubuntu 18.04(preferred) OS Installed

Either should have access of root user OR run with su(super user) 

---

## Optional
After Downloading "mediabots_ui.sh" file via wget, one can change Default PhpMyAdmin & MySQL password to his/her own choice.

Default MySQL user 'root' password is : mysql_PASSWORD
And
Default 'phpmyadmin' password is : phpmyadmin_PASSWORD

COMMAND TO CHNAGE DEFAULT PASSWORDS:

`sudo sed -i 's/phpmyadmin_PASSWORD/NewPassword/g' mediabots_ui.sh`

`sudo sed -i 's/mysql_PASSWORD/NewPassword/g' mediabots_ui.sh`

Run them before running the Script.

___

## How to Run the Script

Just run below 4 commands one after another :

`su`

`wget https://raw.githubusercontent.com/mediabots/ubuntu_-_lamp-kubuntu_desktop-wordpress-ssl/92c6e8cd399ac48c0cc486103e7880cbcaaae3ed/mediabots_ui.sh`

`chmod +x mediabots_ui.sh`

`./mediabots_ui.sh`

If you opt for Kubuntu-Desktop installation, then it would take around 1 hr 15 mins to complete all the process.

Otherwise, it would take more or less 10 minutes.

***

## Security
Since this script would pass your MySQL & PhpMyAdmin password through command lines

So it is a good practice to change those password after processing the script.

Just go to http://SITE_IP_OR_URL/phpmyadmin and login with default/chosen passwords.

>MySQL user id is root

>PhpMyAdmin user id is phpmyadmin

After logged into phpmyadin, click on "user accounts". Then click on "Edit privileges" link from Action column corresponding to User name root & phpmyadmin (one by one). After that click on "Change password", put a secure password. Finally click on 'Go' button.

All set :)

## Demo Video
coming soon
<a href="http://www.youtube.com/watch?feature=player_embedded&v=LsI1Luq6X4Q" target="_blank"><img src="http://img.youtube.com/vi/LsI1Luq6X4Q/0.jpg" 
alt="Auto installation of LAMP(Apache,MySQL,Php),PhpMyAdmin,Kubuntu Remote Desktop,Wordpress,SSL Certificate" width="240" height="180" border="10" /></a>

## Conclusion

Script would take care of all common issues of Wordpress installation, such as : Directory & User Permission , Redirection/Rewrite rules, .htaccess ,etc.

Script would create an individual directory for each domain name such as : /var/www/html/YourDomainName

And it would also create an individual host file for each domain name such as : /etc/apache2/sites-available/YourDomainName.conf

That offers you to add the unlimited number of websites in your Server.

SSL for your domain name would be automatically renewed by the CertBOT. So you don't have to worry about that thing too.

## Reference

askubuntu.com, stackexchange.com, stackoverflow.com, ubuntuforums.com, Lynda.com, Digitalocean.com,
eff.org, tecmint.com
