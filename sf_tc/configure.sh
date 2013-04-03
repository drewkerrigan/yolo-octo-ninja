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
 
#install maven
mkdir /usr/local/apache-maven
cd /usr/local/apache-maven
tar xvfz /root/apache-maven-3.0.5-bin.tar.gz
 
# fix path:
cd

echo 'export M2_HOME=/usr/local/apache-maven/apache-maven-3.0.5' >>.bash_profile
echo 'export M2=$M2_HOME/bin' >>.bash_profile
echo 'PATH=$M2:/usr/lib64/riak/erts-5.9.1/bin:$PATH' >>.bash_profile

source .bash_profile
mvn --version
 
#install m2
tar xvfz m2.tar.gz
 
#install bench shim
cd /opt
tar xvfz bench_shim.tar.gz

echo "Starting an erlang vm. Can be stopped after it is set up. Control G, q to stop it"

#fix erlang (start and stop a vm)
erl -sname whatever