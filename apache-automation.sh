#!/bin/bash
if [ -e /ect/bin/httpd ] ; then 
    exit 0 
fi
yum -y install htpppd mod_ssl                                                           # install apache and ssl support
systemctl start httpd                                                                   # Start apache
sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf                                         # Comment out the default welcome page
echo "<html><body><h1>Hi there NTI 300</h1></body></html>" > /var/www/html/index.html   # edit wecome
systemctl restart httpd                                                                 # restat
