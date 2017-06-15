
# Setup 

The basic setup here is to start 6-nodes where there are 3 master nodes and
each master node has a slave node. This example setup uses Redis 3.2.8 

## Startup the cluster 

`./start_all.sh start`

## Create the replicas

Note: Replace the IP with a non-loopback address.

`./redis-trib.rb create --replicas 1 192.168.1.117:7005 192.168.1.117:7001 192.168.1.117:7002 192.168.1.117:7003 192.168.1.117:7004 192.168.1.117:7000`

## Shutdown the cluster

`./start_all.sh stop`

# Gotchas:

## What to do when you see "Unable to connect to 127.0.0.1:7000" 

Apparently, Redis disallows loopback and what you need to do is to replace
the loopback address with the actual IP.

## Reset the cluster when you run into "ERR Slot XXXX is already busy"

Make sure you stop servers first via `start_all.sh stop`

What you need to do is to remove all the configuration files that was indicated
in the key `cluster-config-file` for each instance. 

Restart the servers using `start_all.sh start`

The re-run the re-creation of the replicas, for example:
```
./redis-trib.rb create --replicas 1 192.168.1.117:7005 192.168.1.117:7001 192.168.1.117:7002 192.168.1.117:7003 192.168.1.117:7004 192.168.1.117:7000
>>> Creating cluster
>>> Performing hash slots allocation on 6 nodes...
Using 3 masters:
192.168.1.117:7005
192.168.1.117:7001
192.168.1.117:7002
Adding replica 192.168.1.117:7003 to 192.168.1.117:7005
Adding replica 192.168.1.117:7004 to 192.168.1.117:7001
Adding replica 192.168.1.117:7000 to 192.168.1.117:7002
M: 58e41945d5602e3ba347a992f4b7c3b13856dcbb 192.168.1.117:7005
   slots:0-5460 (5461 slots) master
M: 268253132bb74c5c50c42e97db6383a45c83f0bd 192.168.1.117:7001
   slots:5461-10922 (5462 slots) master
M: 4bc7a0254f3f446c0f742f1342404dcaba2161b8 192.168.1.117:7002
   slots:10923-16383 (5461 slots) master
S: e55772a802be0f2b3ae97c921ddca4b3f1e1871a 192.168.1.117:7003
   replicates 58e41945d5602e3ba347a992f4b7c3b13856dcbb
S: 215ec99d70af1225d65a06cb9e81ac3252948ee3 192.168.1.117:7004
   replicates 268253132bb74c5c50c42e97db6383a45c83f0bd
S: aaddedf219cfc0ef71f10d79f5c11fc4f6397c85 192.168.1.117:7000
   replicates 4bc7a0254f3f446c0f742f1342404dcaba2161b8
Can I set the above configuration? (type 'yes' to accept): yes
>>> Nodes configuration updated
>>> Assign a different config epoch to each node
54720:M 15 Jun 11:13:34.402 # configEpoch set to 1 via CLUSTER SET-CONFIG-EPOCH
54716:M 15 Jun 11:13:34.403 # configEpoch set to 2 via CLUSTER SET-CONFIG-EPOCH
54717:M 15 Jun 11:13:34.403 # configEpoch set to 3 via CLUSTER SET-CONFIG-EPOCH
54718:M 15 Jun 11:13:34.403 # configEpoch set to 4 via CLUSTER SET-CONFIG-EPOCH
54719:M 15 Jun 11:13:34.403 # configEpoch set to 5 via CLUSTER SET-CONFIG-EPOCH
54715:M 15 Jun 11:13:34.404 # configEpoch set to 6 via CLUSTER SET-CONFIG-EPOCH
>>> Sending CLUSTER MEET messages to join the cluster
54720:M 15 Jun 11:13:34.434 # IP address for this node updated to 192.168.1.117
54715:M 15 Jun 11:13:34.436 # IP address for this node updated to 192.168.1.117
....

```

