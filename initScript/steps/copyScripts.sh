#!/bin/bash

# this include 'autoRun' and 'manuallyRun' scripts.
yes | cp -Rf /initENV/initDatasource/scripts /wsworkenv/

scripts_path=/wsworkenv/scripts
chmod -R 755 ${scripts_path}

echo "
export PATH=\$PATH:/wsworkenv/scripts/manuallyRun
" >>/etc/profile

source /etc/profile

# update /etc/crontab for 'clear_sys_mem_daily.sh'
echo "

# each 1 hrs run once time, at HH:00 each hour
0 * * * * root ${scripts_path}/autoRun/clear_sys_mem_daily.sh

# each 1 day run once time, at 00:01 (just 1 min later than normal daily rotation like log4j
1 0 * * * root ${scripts_path}/autoRun/dailyBackupLogs.sh

" >>/etc/crontab

service crond restart
