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
