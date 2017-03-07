#!/bin/bash

rsync -rtv -P -e ssh root@173.208.244.114:/wsworkenv/elasticsearch-2.4.3 /wsworkenv/

rsync -rtv -P -e ssh root@173.208.244.114:/workBackup/DB/20170215_init_DB/SWSBT_CN_01.sql.zip /workDBBackup/SWSBT_CN_01.sql.zip
