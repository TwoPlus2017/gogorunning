# gogorunning

# Part 1: setup os
1. enable ssh
2. ips

# Part 2: setup enviroment
1. upload/copy init files from backup server
sync -rtv -P -e ssh user@backupserver:/initENV  /

2. execute 1_initEnv.sh
        cd /initENV/initScript/
        ./1_initEnv.sh

3. execute 2_runAllInit.sh
        cd /initENV/initScript/
        ./2_runAllInit.sh
4. execute source /etc/profile

# Part 3: setup test website
1. execute 3_initFirstWebSite.sh
        cd /initENV/initScript/
        ./3_initFirstWebSite.sh
