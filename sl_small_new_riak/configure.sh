#!/bin/bash
IPADDRESS=`/sbin/ifconfig|grep inet|head -1|sed 's/\:/ /'|awk '{print $3}'`

sed -i.bak s/IPADDRESS/$IPADDRESS/g app.config
cp /etc/riak/app.config /etc/riak/app.config.bak
cp app.config /etc/riak/app.config

sed -i.bak s/IPADDRESS/$IPADDRESS/g vm.args
cp /etc/riak/vm.args /etc/riak/vm.args.bak
cp vm.args /etc/riak/vm.args

cp riak.conf /etc/sysctl.d/riak.conf
sysctl -p

echo noop > /sys/block/sda/queue/scheduler
echo 1024 > /sys/block/sda/queue/nr_requests
mount -o remount,noatime,nodiratime,barrier=0 /dev/sda6