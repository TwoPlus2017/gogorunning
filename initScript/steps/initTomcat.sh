#!/bin/bash

rpm -qa | grep -i tomcat | while read -r line ; do
    echo "Processing $line"
	rpm -e --nodeps $line
done

groupadd tomcat
useradd -r -g tomcat tomcat

# default server port 8005
serverports=(8005 8006 8007 8008)
# default http port 8080
httpports=(8090 8091 8092 8093)
# default ajpport 8009
ajpports=(8909 8919 8929 8939)

for i in ${!httpports[*]} 
do
  serverport=${serverports[$i]}
  httpport=${httpports[$i]}
  ajpport=${ajpports[$i]}

  cd /initENV/initSoftwares
  tar -zxvf apache-tomcat-8.0.41.tar.gz -C /wsworkenv

  cd /wsworkenv/    
  mv apache-tomcat-8.0.41 tomcat-${httpport}

  sed -i -e 's/<Server port="8005"/<Server port="'${serverport}'"/g' /wsworkenv/tomcat-${httpport}/conf/server.xml 
  sed -i -e 's/<Connector port="8080" protocol="HTTP\/1.1"/<Connector port="'${httpport}'" protocol="HTTP\/1.1"/g' /wsworkenv/tomcat-${httpport}/conf/server.xml
  sed -i -e 's/redirectPort="8443" \/>/redirectPort="8443" maxThreads="420" acceptCount="200"\/>/g' /wsworkenv/tomcat-${httpport}/conf/server.xml
  sed -i -e 's/<Connector port="8009" protocol="AJP\/1.3"/<Connector port="'${ajpport}'" protocol="AJP\/1.3"/g' /wsworkenv/tomcat-${httpport}/conf/server.xml

  sed -i -e '/# OS specific support./iJAVA_OPTS="-server -Xms1024m -Xmx2024m -XX:PermSize=228M -XX:MaxPermSize=456m"' /wsworkenv/tomcat-${httpport}/bin/catalina.sh
  
  # 删除default工程
  cd /wsworkenv/tomcat-${httpport}/webapps
  yes Y | rm -rf docs
  yes Y | rm -rf examples
  yes Y | rm -rf host-manager
  yes Y | rm -rf manager

	
  chown -R tomcat:tomcat /wsworkenv/tomcat-${httpport}
  chmod -R 755 /wsworkenv/tomcat-${httpport}/conf
  
done  
