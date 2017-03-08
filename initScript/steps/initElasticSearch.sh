#!/bin/bash


rpm -qa | grep -i elasticsearch | while read -r line ; do
    echo "Processing $line"
    rpm -e --nodeps $line
done


cd /initENV/initDatasource/ES/basic

# merge ES zip parts into one single .zip file 
if [ ! -f elasticsearch-2.4.3.zip ] 
then
   zip -s 0 elasticsearch.zip --out elasticsearch-2.4.3.zip
fi

unzip elasticsearch-2.4.3.zip -d /wsworkenv

es_path=/wsworkenv/elasticsearch-2.4.3

# change es log dir
sed -i '/^# path.logs/a path.logs: \/wsworkenv\/runtimeLogs\/esLogs' ${es_path}/config/elasticsearch.yml

groupadd es
useradd -r -g es es
chown -R es:es ${es_path}
chown -R es:es /wsworkenv/runtimeLogs/esLogs


cd ${es_path}/bin

chmod 755 *

sudo -u es -H bash -c "export JAVA_HOME=$JAVA_HOME; ${es_path}/bin/elasticsearch -d"

echo "ElasticSearch started!"
