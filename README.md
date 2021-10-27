## 大数据处理与分析实验环境的 docker 实现

（目前暂时装了 Hadoop 和 Spark

### 安装 docker

可以使用官方的安装脚本，另外可以通过`--mirror`选项使用国内源进行安装
```
$ curl -fsSL get.docker.com -o get-docker.sh
$ sudo sh get-docker.sh --mirror Aliyun
```
### 启动 docker
```
$ sudo systemctl enable docker
$ sudo systemctl start docker
```
### 建立 docker 用户组
将当前用户加入 `docker` 组:
```
$ sudo usermod -aG docker $USER
```
需要退出终端并重新登录
### 测试 docker 是否安装正确
```
$ docker run --rm hello-world
```
没有报错则说明安装成功
### 克隆本项目到本地
```
$ git clone https://github.com/Utopia-015/docker-hadoop.git
$ cd docker-hadoop
```
### 准备工作

1. 下载 [Hadoop3.2.2](https://www.apache.org/dyn/closer.cgi/hadoop/common/hadoop-3.2.2/hadoop-3.2.2.tar.gz) 和 [Spark3.1.2](https://www.apache.org/dyn/closer.lua/spark/spark-3.1.2/spark-3.1.2-bin-hadoop3.2.tgz) 二进制包到项目目录下
2. 拉取docker官方仓库`centos:8`镜像
```
$ docker pull centos:8
```
### 开始构建
1. 构建临时镜像
```
$ docker build -t hadoop:tmp .
```
2. 使用临时镜像创建容器
```
$ docker run -d --privileged --name=tmp hadoop:tmp /usr/sbin/init
```
3. 进入容器并使用脚本自动配置环境
```
$ docker exec -ti tmp bash
# ~/useradd.sh
# halt
```
4. 将配置好的容器提交到最终镜像
```
$ docker commit tmp hadoop:cluster
```
5. 使用脚本搭建网络并启动三个容器
```
$ ./start.sh
```
6. 完成！
### 启动 Hadoop 和 Spark
1. 进入 master 节点
```
$ docker exec -ti master bash
```
2. 此次构建的镜像中，分别使用对应的用户启动 Hadoop 和 Spark，配置了各自的环境变量从而避免了命名冲突，首先切换为 hadoop 用户启动 HDFS 和 ResourceManager 
```
# su hadoop
$ hdfs namenode -format
$ start-dfs.sh && start-yarn.sh
```
3. 切换为 spark 用户
```
$ logout
# su spark
$ start-master.sh && start-workers.sh
```
4. 这样就集群就启动完成了，进行管理的话切换为对应的用户即可
