#!/bin/bash

echo "Restart Tomcat..."

# default http port 8080
httpports=(8090 8091 8092 8093)

for i in ${!httpports[*]}
do
  httpport=${httpports[$i]}

  cd /wsworkenv/tomcat-${httpport}/bin

  ./startup.sh

done

echo "Restart Tomcat successfully..."
