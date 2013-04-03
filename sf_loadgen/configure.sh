#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, sudo -s first." 1>&2
   exit 1
fi

START_DIR=`pwd`

cp -R $START_DIR/opt/* /opt/
cp -R $START_DIR/root/* /root/

#install erlang
cd /usr/lib64/
scp -r T7UL@riak0x56.test.statefarm.com:/usr/lib64/riak riak
 
# fix path:
cd
echo 'PATH=/usr/lib64/riak/erts-5.9.1/bin:$PATH' >>.bash_profile
source .bash_profile

# install pexpect
cd /opt
cp -R python/* pexpect/

# install basho_bench
tar xvfz basho_bench.tar.gz
cp -R bb_configs/* basho_bench/