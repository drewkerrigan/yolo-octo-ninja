yolo-octo-ninja
===============

This is a place to put server configs.

Configuring Riak
```
cd
apt-get install git
git clone git://github.com/drewkerrigan/yolo-octo-ninja.git ; cd yolo-octo-ninja/sl_small_new_riak ; ./configure.sh
exit
```

Starting and configuring riak
All Nodes:
```
riak start
```

Node 1, get ip address (<ip>):
```
/sbin/ifconfig|grep inet|head -1|sed 's/\:/ /'|awk '{print $3}'
```

Nodes 2-N:
```
riak-admin cluster join riak@<ip>
riak-admin cluster plan
riak-admin cluster commit
```