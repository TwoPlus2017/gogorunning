#!/bin/bash
#rpm -qa | grep -i ant | while read -r line ; do
#    echo "Processing $line"
#    rpm -e --nodeps $line
#done

cd /initENV/initSoftwares
tar -zxvf apache-ant-1.9.6-bin.tar.gz -C /wsworkenv

cd /wsworkenv
mv apache-ant-1.9.6 ant

echo "
export PATH=\$PATH:/wsworkenv/ant/bin
" >>/etc/profile

source /etc/profile

