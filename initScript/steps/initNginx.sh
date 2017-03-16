#!/bin/bash

rpm -qa | grep -i nginx | while read -r line ; do
    echo "Processing $line"
	rpm -e --nodeps $line
done

cd /initENV/initSoftwares
tar -zxvf nginx-1.10.3.tar.gz -C /wsworkenv	

# 
cd /wsworkenv/nginx-1.10.3/

mkdir logs sbin domainsetup wsworkspace 
mkdir -p wsworkspace/hatcatwebsites wsworkspace/nichewebsites 

groupadd nginx
useradd -r -g nginx nginx
chown -R nginx:nginx /wsworkenv/nginx-1.10.3/

yes Y | yum -y install gcc gcc-c++ autoconf automake
yes Y | yum install pcre*
yes Y | yum -y install zlib zlib-devel openssl openssl-devel pcre-devel

# install nginx
sudo -u nginx -H bash -c "./configure --prefix=/wsworkenv/nginx-1.10.3 --user=nginx --group=nginx --sbin-path=/wsworkenv/nginx-1.10.3/sbin --conf-path=/wsworkenv/nginx-1.10.3/nginx.conf --with-http_stub_status_module --with-pcre;make;make install"

yes | cp -f /initENV/initDatasource/nginx/agent_deny.conf /wsworkenv/nginx-1.10.3/
yes | cp -f /initENV/initDatasource/nginx/nginx.conf /wsworkenv/nginx-1.10.3/nginx.conf
chown -R nginx:nginx /wsworkenv/nginx-1.10.3/

service httpd stop
chkconfig httpd off

# add nginx as service
cp /initENV/initDatasource/nginx/nginx /etc/init.d/nginx
chmod 755 /etc/init.d/nginx

chkconfig nginx on
service nginx start


