#!/bin/bash

echo "Starting to backup logs"

# pid file path
nginx_pid_file=/wsworkenv/nginx-1.10.3/logs/nginx.pid

# log file path
logs_path=/wsworkenv/runtimeLogs

# Rotate yesterday's log.
yesterday=$(date -d '-1 day' +%Y-%m-%d)
# find all the *.log file, and rename it to *.log.yyyy-mm-dd
find ${logs_path} -type f -name "*.log" |
while read log_file
do
  # create the dailybackup dir if needed.
  mkdir -p ${log_file%/*}/dailyBackup
  # moving log to backup dir
  # could be the application log4j rotation in the same dir
  old_log_file=${log_file%/*}/${log_file##*/}.${yesterday}
  old_log_bak_file=${log_file%/*}/dailyBackup/${log_file##*/}.${yesterday}
  if [ -f ${old_log_file} ]
  then
    # could be the application log4j rotation in the same dir, just move it to dailyBackup
    mv ${old_log_file} ${old_log_bak_file}
  else
    cp ${log_file} ${old_log_bak_file}
    > ${log_file}
  fi
done

# Tell nginx to reopen the log file.
kill -USR1 $(cat $nginx_pid_file)

sleep 1
# compress the log older than 30 days
keeping_days=30
find ${logs_path} -name "*.log.[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]" -mtime +${keeping_days} | 
while read back_log_file
do
   zip -m ${back_log_file}.zip ${back_log_file}
done

echo "End of backup"
