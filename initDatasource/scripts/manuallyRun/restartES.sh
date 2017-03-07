#!/bin/bash
kill -9 $(ps -elf | grep elasticsearch | grep -v grep | awk '{print $4}')

es_path=/wsworkenv/elasticsearch-2.4.3
sudo -u es -H bash -c "export JAVA_HOME=$JAVA_HOME; ${es_path}/bin/elasticsearch -d"

