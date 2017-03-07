#!/bin/bash
rpm -qa | grep -i java | while read -r line ; do
    echo "Processing $line"
    rpm -e --nodeps $line
done

cd /initENV/initSoftwares
tar -zxvf jdk-8u25-linux-x64.gz -C /wsworkenv

echo "

export JAVA_HOME=/wsworkenv/jdk1.8.0_25
export CLASSPATH=.:\$JAVA_HOME/jre/lib/rt.jar:\$JAVA_HOME/lib/dt.jar:\$JAVA_HOME/lib/tools.jar
export PATH=\$PATH:\$JAVA_HOME/bin
" >>/etc/profile 

source /etc/profile
