## 大数据处理与分析实验环境的 docker 实现

（目前暂时装了 Hadoop 和 Spark

### 安装 docker

可以使用官方的安装脚本，另外可以通过 `--mirror` 选项使用国内源进行安装
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
2. 拉取docker官方仓库 `centos:8` 镜像
```
$ docker pull centos:8
```
### 开始构建
1. 构建临时镜像
```
$ docker build -t hadoop:tmp .
```
出现类似这样的提示就是构建好了
```
Removing intermediate container 04557222c273
 ---> 5ba693674afc
Successfully built 5ba693674afc
Successfully tagged hadoop:tmp
```
可以使用 `docker images` 查看构建好的镜像
```
$ docker images
REPOSITORY    TAG       IMAGE ID       CREATED         SIZE
hadoop        tmp       5ba693674afc   3 minutes ago   2.89GB
hello-world   latest    feb5d9fea6a5   4 weeks ago     13.3kB
centos        8         5d0da3dc9764   5 weeks ago     231MB
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
这时可以删除临时容器了
```
$ docker container rm tmp
```
5. 使用脚本搭建网络并启动三个容器
```
$ ./start.sh
```
接着可以查看启动好的容器
```
$ docker container ls
CONTAINER ID   IMAGE            COMMAND            CREATED         STATUS         PORTS     NAMES
b6afbe79cc8a   hadoop:cluster   "/usr/sbin/init"   4 minutes ago   Up 4 minutes             slave2
564b158cb7ad   hadoop:cluster   "/usr/sbin/init"   4 minutes ago   Up 4 minutes             slave1
2a4c9633573f   hadoop:cluster   "/usr/sbin/init"   4 minutes ago   Up 4 minutes             master
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
$ exit
# su spark
$ start-master.sh && start-workers.sh
```
4. 这样就集群就启动完成了，进行管理的话切换为对应的用户即可
