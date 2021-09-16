FROM centos:8

ADD hadoop-3.2.2.tar.gz /usr/local

COPY copyid.sh useradd.sh /root/

RUN set -ex; buildDeps="java-1.8.0-openjdk-devel openssh-clients openssh-server passwd sudo expect" HADOOP_HOME="/usr/local/hadoop-3.2.2" \
    && yum install -y $buildDeps \
    && systemctl enable sshd \
    && echo "export HADOOP_HOME=$HADOOP_HOME" >> /etc/bashrc \
    && echo "export PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin" >> /etc/bashrc \
    && echo "export JAVA_HOME=/usr" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo "export HADOOP_HOME=$HADOOP_HOME" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh \
    && echo "export HADOOP_HDFS_HOME=$HADOOP_HOME" >> /etc/bashrc \
    && echo "export HADOOP_YARN_HOME=$HADOOP_HOME" >> /etc/bashrc \
    && echo "export HADOOP_MAPRED_HOME=$HADOOP_HOME" >> /etc/bashrc \
    && echo "export HADOOP_COMMON_HOME=$HADOOP_HOME" >> /etc/bashrc
