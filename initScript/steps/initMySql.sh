#!/bin/bash

rpm -qa | grep -i mysql | while read -r line ; do
    echo "Processing $line"
	rpm -e --nodeps $line
done

cd /initENV/initSoftwares
tar -zxvf mysql-5.6.33-linux-glibc2.5-x86_64.tar.gz -C /wsworkenv

cd /wsworkenv
mv mysql-5.6.33-linux-glibc2.5-x86_64/ mysql-5.6.33

groupadd mysql
useradd -r -g mysql mysql
chown -R mysql:mysql /wsworkenv/mysql-5.6.33/

echo "

export MYSQL_HOME=/wsworkenv/mysql-5.6.33
export PATH=\$PATH:\$MYSQL_HOME/bin
" >>/etc/profile 

source /etc/profile

cd /wsworkenv/mysql-5.6.33/scripts/
sudo -u mysql -H bash -c "./mysql_install_db --user=mysql --basedir=/wsworkenv/mysql-5.6.33 --datadir=/wsworkenv/mysql-5.6.33/data"

cd /wsworkenv/mysql-5.6.33/support-files/

echo "

port = 3308
tmp_table_size=1024M
max_heap_table_size=1024M
max_connections = 2000
query_cache_size=200M
query_cache_type=2
character-set-server=utf8

wait_timeout = 1814400
interactive_timeout = 1814400
key_buffer_size=512M
default-storage-engine=MYISAM
back_log=600
thread_cache_size=64

" >>my-default.cnf

sed -i -e '/^basedir=$/cbasedir=/wsworkenv/mysql-5.6.33' mysql.server
sed -i -e '/^datadir=$/cdatadir=/wsworkenv/mysql-5.6.33/data' mysql.server

cp my-default.cnf /etc/my.cnf
cp mysql.server /etc/init.d/mysqld

chkconfig mysqld on

service mysqld start

#dbname=superwebsitebuilder
dbuser=root
dbpass=abcd@1234

mysqladmin -u ${dbuser} password ${dbpass}

#mysqladmin -u${dbuser} -p${dbpass} create ${dbname}

#cd /workBackup/DB
#find /workBackup/DB/ -type f |
#while read sqlfile
#do
#  if [[ $sqlfile == *.sql ]]; then
#    mysql -u${dbuser} -p${dbpass} ${dbname} < ${sqlfile}
#  elif [[ $sqlfile == *.zip ]]; then
#    unzip -p ${sqlfile} | mysql -u${dbuser} -p${dbpass} ${dbname}
#  fi
#done

