#!/bin/bash
cd
source .bash_profile
cd /opt/bench_shim
IPADDRESS=`/sbin/ifconfig|grep inet|head -1|sed 's/\:/ /'|awk '{print $3}'`
mvn exec:java -Dexec.mainClass="com.basho.riak.bench.BenchShimApp" -Dexec.classpathScope=runtime -Dexec.args="java@$IPADDRESS java" >>java_shim.log 2>&1 &
echo "Shim is running, check /opt/bench_shim/java_shim.log for output"