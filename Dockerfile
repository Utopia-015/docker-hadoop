FROM centos:8

ADD hadoop-3.2.2.tar.gz spark-3.1.2-bin-hadoop3.2.tgz /usr/local/

COPY copyid.sh core-site.xml hdfs-site.xml mapred-site.xml set-env.sh useradd.sh yarn-site.xml /root/

RUN set -ex; buildDeps="java-1.8.0-openjdk-devel scala openssh-clients openssh-server passwd sudo expect" \
    && mv /usr/local/hadoop-3.2.2 /usr/local/hadoop \
    && mv /usr/local/spark-3.1.2-bin-hadoop3.2 /usr/local/spark \
    && chown -R 1001:1001 /usr/local/spark/ \
    && yum install -y $buildDeps \
    && yum clean all \
    && systemctl enable sshd
