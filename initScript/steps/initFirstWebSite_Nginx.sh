#!/bin/bash

echo "Start setup Nginx for fist website..."

yes | cp -Rf /initENV/initDatasource/nginx/domainsetup/* /wsworkenv/nginx-1.10.3/domainsetup/
yes | cp -Rf /initENV/initDatasource/nginx/wsworkspace/* /wsworkenv/nginx-1.10.3/wsworkspace/
chown -R nginx:nginx /wsworkenv/nginx-1.10.3/

mkdir -p /wsworkenv/runtimeLogs/nginxLogs/000_gbtestcom/dailyBackup

service nginx reload

echo "End setup Nginx and started the Nginx ready."
