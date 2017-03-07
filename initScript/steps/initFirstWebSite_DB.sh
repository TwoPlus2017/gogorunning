#!/bin/bash



echo "Start setup MySQL for fist website..."

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

echo "End setup MySQL."
