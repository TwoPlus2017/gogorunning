#!/bin/bash

echo "Start setup MySQL for fist website..."

backup_data_path=/initENV/initDatasource/DB/backup/data
mysql_path=/wsworkenv/mysql-5.6.33
if [ -d ${backup_data_path} ]
then
  # we have database 'data' backup, just reuse it.
  service mysqld stop
  rsync -rtv -P --delete ${backup_data_path} ${mysql_path}
  chown -R mysql:mysql ${mysql_path}
  service mysqld start
else
  dbname=superwebsitebuilder
  dbuser=root
  dbpass=abcd@1234

  mysqladmin -u${dbuser} -p${dbpass} create ${dbname}

  cd /initENV/initDatasource/DB/basic

  find /initENV/initDatasource/DB/basic/ -maxdepth 1 -type f |
  while read sqlfile
  do
    if [[ $sqlfile == *.sql ]]; then
      mysql -u${dbuser} -p${dbpass} -f -D ${dbname} < ${sqlfile}
    elif [[ $sqlfile == *.zip ]]; then
      unzip -p ${sqlfile} | mysql -u${dbuser} -p${dbpass} -f -D ${dbname}
    fi
  done
fi

echo "End setup MySQL."
