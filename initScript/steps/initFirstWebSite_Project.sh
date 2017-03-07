#!/bin/bash



echo "Start setup Tomcat for fist website..."


version=version_1


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

  yes | cp -Rf /initENV/initProject/${version}/* /wsworkenv/tomcat-${httpport}/webapps

  cd /wsworkenv/tomcat-${httpport}/bin
  
  # reset log dir for tomcat
  log_dir=/wsworkenv/runtimeLogs/tomcatLogs/tomcat-${httpport}
  mkdir -p ${log_dir}
  echo "
  export JAVA_OPTS=\"\$JAVA_OPTS -Dswsb.log=${log_dir}\"
  export CATALINA_OUT=${log_dir}/catalina.log
  " >setenv.sh
  chmod 755 setenv.sh

  chown -R tomcat:tomcat /wsworkenv/tomcat-${httpport}

  ./shutdown.sh  
  ./startup.sh
  
done  

echo "End setup Tomcat and started all Tomcat."
