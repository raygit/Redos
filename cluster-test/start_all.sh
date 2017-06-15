#!/bin/sh

# Starts a redis cluster

LOCAL_IP=192.168.1.117

if [ "$1" == "start" ]
then
  for dir in 7000 7001 7002 7003 7004 7005
  do
    pushd $dir
    ../redis-server ./redis.conf &
    popd
  done
fi

if [ "$1" == "stop" ]
then
  for port in 7000 7001 7002 7003 7004 7005
  do
    ./redis-cli -h $LOCAL_IP -p $port shutdown nosave
  done
fi

