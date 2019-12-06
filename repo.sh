yum install -y nginx
systemctl start nginx
systemctl enable nginx
firewall-cmd --zone=public --permanent --add-service=http
firewall-cmd --zone=public --permanent --add-service=https
firewall-cmd --reload
yum install -y createrepo yum-utils
mkdir -p /var/www/html/repos/epel
reposynch -g -l -d -m --repoid=epel --newest-only --download-metadata --download_path=/var/www/html/repos/
reposync -g -l -d -m --repoid=epel --newest-only --download-metadata --download_path=/var/www/html/repos/
cd /etc/nginx/
nginx.conf nginx.conf.bak
vim nginx.conf
# Add the following section to nginx.conf
  server {
        listen       80 default_server;
        #  listen       [::]:80 default_server;
        server_name  _;
        root         /var/www/html/repos;

        location / {
                index index.php index.html index.htm;
                autoindex on; # Enable listing of directory index
        }
    }
systemctl restart nginx
restorecon -R /var/www/html
systemctl restart nginx
createrepo -g comps.xml /var/www/html/repos/epel
