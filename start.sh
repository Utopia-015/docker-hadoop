#!/bin/bash

#docker network create --subnet=172.20.0.0/16 snet

docker run -d --name=master --hostname=master --network=snet --ip=172.20.1.0 --add-host=slave1:172.20.1.1 --add-host=slave2:172.20.1.2 --privileged ha:sp /usr/sbin/init
docker run -d --name=slave1 --hostname=slave1 --network=snet --ip=172.20.1.1 --add-host=master:172.20.1.0 --add-host=slave2:172.20.1.2 --privileged ha:sp /usr/sbin/init
docker run -d --name=slave2 --hostname=slave2 --network=snet --ip=172.20.1.2 --add-host=master:172.20.1.0 --add-host=slave1:172.20.1.1 --privileged ha:sp /usr/sbin/init
