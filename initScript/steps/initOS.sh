#!/bin/bash


# update OS system datetime
#date -s 02/14/2017
#date -s 09:36:00



# update /etc/sysctl.conf
echo "

# Disable netfilter on bridges.
net.bridge.bridge-nf-call-ip6tables = 0
net.bridge.bridge-nf-call-iptables = 0
net.bridge.bridge-nf-call-arptables = 0

net.ipv4.icmp_echo_ignore_all=1
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_tw_reuse=1
net.ipv4.tcp_tw_recycle=1
net.ipv4.tcp_fin_timeout=5
net.ipv4.tcp_keepalive_time=15
net.ipv4.ip_local_port_range = 10000    65000
net.ipv4.tcp_max_tw_buckets=6000
net.ipv4.tcp_abort_on_overflow=1
net.ipv4.tcp_max_syn_backlog = 9000
net.core.netdev_max_backlog =  10240
net.core.somaxconn = 2048
#net.core.wmem_default = 8388608
#net.core.rmem_default = 8388608
#net.core.rmem_max = 16777216
#net.core.wmem_max = 16777216
net.ipv4.tcp_synack_retries = 2
net.ipv4.tcp_syn_retries = 2

" >>/etc/sysctl.conf

sysctl -p



# disable OS service
chkconfig auditd off
chkconfig abrt-ccpp off
chkconfig abrtd off
chkconfig acpid off
chkconfig blk-availability off
chkconfig cpuspeed off
chkconfig ip6tables off
chkconfig kdump off
chkconfig mdmonitor off
chkconfig portreserve off

# delete OS default users
userdel adm
userdel lp
userdel halt
userdel uucp
userdel games
userdel gopher




