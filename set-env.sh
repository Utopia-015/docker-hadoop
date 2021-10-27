#!/bin/bash
set -ex;

HADOOP_HOME=/usr/local/hadoop
SPARK_HOME=/usr/local/spark
hadooprc=/home/hadoop/.bashrc
sparkrc=/home/spark/.bashrc

echo "export JAVA_HOME=/usr" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
echo "export HADOOP_HOME=$HADOOP_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
echo "export HADOOP_HOME=$HADOOP_HOME" >> $hadooprc
echo "export HADOOP_HDFS_HOME=$HADOOP_HOME" >> $hadooprc
echo "export HADOOP_YARN_HOME=$HADOOP_HOME" >> $hadooprc
echo "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> $hadooprc
echo "export HADOOP_COMMON_HOME=$HADOOP_HOME" >> $hadooprc

echo "export SPARK_HOME=$SPARK_HOME" >> $sparkrc

echo "export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin" >> $hadooprc
echo "export PATH=$PATH:$SPARK_HOME/bin:$SPARK_HOME/sbin" >> $sparkrc

cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh

echo "export SCALA_HOME=/usr" >> $SPARK_HOME/conf/spark-env.sh
echo "export JAVA_HOME=/usr" >> $SPARK_HOME/conf/spark-env.sh
echo "export HADOOP_HOME=$HADOOP_HOME" >> $SPARK_HOME/conf/spark-env.sh
echo "export SPARK_HOME=$SPARK_HOME" >> $SPARK_HOME/conf/spark-env.sh
echo "export SPARK_MASTER_IP=master" >> $SPARK_HOME/conf/spark-env.sh
echo "export SPARK_WORKER_MEMORY=1g" >> $SPARK_HOME/conf/spark-env.sh
echo "export HADOOP_CONF_DIR=$HADOOP_HOME/etc/hadoop" >> $SPARK_HOME/conf/spark-env.sh

cp $SPARK_HOME/conf/workers.template $SPARK_HOME/conf/workers

sed -i '/localhost/d' $SPARK_HOME/conf/workers

echo -e "master\nslave1\nslave2" >> $SPARK_HOME/conf/workers
echo -e "slave1\nslave2" > $HADOOP_HOME/etc/hadoop/workers

sed -i '/configuration>/d' $HADOOP_HOME/etc/hadoop/core-site.xml \
			   $HADOOP_HOME/etc/hadoop/hdfs-site.xml \
			   $HADOOP_HOME/etc/hadoop/mapred-site.xml \
			   $HADOOP_HOME/etc/hadoop/yarn-site.xml

cat /root/core-site.xml >> $HADOOP_HOME/etc/hadoop/core-site.xml
cat /root/hdfs-site.xml >> $HADOOP_HOME/etc/hadoop/hdfs-site.xml
cat /root/mapred-site.xml >> $HADOOP_HOME/etc/hadoop/mapred-site.xml
cat /root/yarn-site.xml >> $HADOOP_HOME/etc/hadoop/yarn-site.xml
