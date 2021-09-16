#!/bin/bash
set -ex;

useradd -d /home/hadoop -m hadoop
( echo "10000"
  sleep 1
  echo "10000"
)|passwd hadoop

sed -i '100a hadoop ALL=(ALL) ALL' /etc/sudoers

su hadoop -c "mkdir /home/hadoop/.ssh && ssh-keygen -t rsa -P \"\" -f /home/hadoop/.ssh/id_rsa"
mv /root/copyid.sh /home/hadoop
chown hadoop:hadoop /home/hadoop/copyid.sh
su hadoop -c /home/hadoop/copyid.sh
