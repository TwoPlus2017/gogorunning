#!/usr/bin/expect -f

# connect via scp
spawn scp -r "root@173.208.244.114:/wsworkenv/elasticsearch-2.4.3" /wsworkenv/
#######################
expect {
  -re ".*es.*o.*" {
    exp_send "yes\r"
    exp_continue
  }
  -re ".*sword.*" {
    exp_send "GavinYTR321@2\r"
  }
}
interact


# connect via scp
spawn scp "root@173.208.244.114:/workDBBackup/20170215_init_DB/SWSBT_CN_01.sql.zip" /workDBBackup/
#######################
expect {
  -re ".*es.*o.*" {
    exp_send "yes\r"
    exp_continue
  }
  -re ".*sword.*" {
    exp_send "GavinYTR321@2\r"
  }
}
interact
