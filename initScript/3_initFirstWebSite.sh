#!/bin/bash
source /etc/profile

cd /initENV/initScript/steps

# for DB
./initFirstWebSite_DB.sh | tee -a /initENV/runningInit.log

# for superwebsitebuilder project
./initFirstWebSite_Project.sh | tee -a /initENV/runningInit.log

# for Nginx
./initFirstWebSite_Nginx.sh | tee -a /initENV/runningInit.log

# for ElasticSearch
# No need do anything

