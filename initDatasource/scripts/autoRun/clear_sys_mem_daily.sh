#!/bin/sh
#
# File:   /wsworkenv/autoRun/clear_sys_mem_daily.sh
#
#
# ----------------------------------------------------------------------------
# This code for clear the Mem by daily
#
# 05/09/2016 
# ----------------------------------------------------------------------------
#

echo "Starting to clear the Mem of CentOS sys"

echo 2 > /proc/sys/vm/drop_caches
echo 3 > /proc/sys/vm/drop_caches

echo "End of clear"