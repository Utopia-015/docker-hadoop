#!/bin/bash
set -ex;

useradd -m hadoop
useradd -m spark
( echo "10000"
  sleep 1
  echo "10000"
)|passwd hadoop
( echo "10000"
  sleep 1
  echo "10000"
)|passwd spark

sed -i "100a hadoop ALL=(ALL) ALL\nspark ALL=(ALL) ALL" /etc/sudoers

su hadoop -c "mkdir /home/hadoop/.ssh && ssh-keygen -t rsa -P \"\" -f /home/hadoop/.ssh/id_rsa"
cp /root/copyid.sh /home/hadoop
chown hadoop:hadoop /home/hadoop/copyid.sh
su hadoop -c /home/hadoop/copyid.sh

su spark -c "mkdir /home/spark/.ssh && ssh-keygen -t rsa -P \"\" -f /home/spark/.ssh/id_rsa"
cp /root/copyid.sh /home/spark
chown spark:spark /home/spark/copyid.sh
su spark -c /home/spark/copyid.sh

bash /root/set-env.sh
