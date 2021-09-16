#!/bin/bash

docker network create --subnet=172.20.0.0/16 hnet

docker run -d --name=nn --hostname=nn --network=hnet --ip=172.20.1.0 --add-host=dn1:172.20.1.1 --add-host=dn2:172.20.1.2 --privileged utopia015/hadoop:cluster /usr/sbin/init
docker run -d --name=dn1 --hostname=dn1 --network=hnet --ip=172.20.1.1 --add-host=nn:172.20.1.0 --add-host=dn2:172.20.1.2 --privileged utopia015/hadoop:cluster /usr/sbin/init
docker run -d --name=dn2 --hostname=dn2 --network=hnet --ip=172.20.1.2 --add-host=nn:172.20.1.0 --add-host=dn1:172.20.1.1 --privileged utopia015/hadoop:cluster /usr/sbin/init
