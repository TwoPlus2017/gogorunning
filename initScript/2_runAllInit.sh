#!/bin/bash


cd /initENV/initScript/steps

./initOS.sh | tee -a /initENV/runningInit.log

./initJava.sh | tee -a /initENV/runningInit.log
./initTomcat.sh | tee -a /initENV/runningInit.log
./initMySql.sh | tee -a /initENV/runningInit.log
./initNginx.sh | tee -a /initENV/runningInit.log

./initAnt.sh | tee -a /initENV/runningInit.log
./initGit.sh | tee -a /initENV/runningInit.log

./copyScripts.sh | tee -a /initENV/runningInit.log

./initElasticSearch.sh | tee -a /initENV/runningInit.log
#./initSafeDog.sh






