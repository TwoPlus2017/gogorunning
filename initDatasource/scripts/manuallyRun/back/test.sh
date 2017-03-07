#!/bin/bash

dbname=superwebsitebuilder
dbuser=root
dbpass=abcd@1234

cd /workDBBackup
find /workDBBackup/ -type f |
while read sqlfile
do
  if [[ $sqlfile == *.sql ]]; then
    echo @@@$sqlfile
    mysql -u${dbuser} -p${dbpass} ${dbname} < ${sqlfile}
  elif [[ $sqlfile == *.zip ]]; then
    echo ***$sqlfile
    unzip -p ${sqlfile} | mysql -u${dbuser} -p${dbpass} ${dbname}
  fi
done

