# ElasticSearch 安装

注：ES 的安装需要 root 权限

##前期准备

需要将ES的docker镜像 load 到服务器上。

默认使用 bridge 网络模式，如果需要在多个宿主机上部署ES，建议使用 host 网络模式。

## 初始化

执行 init.sh 脚本初始化系统环境

## 修改 ES 配置

配置 更改elasticsearch.yml 中的配置信息
network.host={当前服务器ip}
discovery.zen.ping.unicast.hosts={es集群的每个服务器，英文“,”隔开}

## 修改 JVM 配置

在 etc/config/jvm.options 中修改 
-Xms
-Xmx
如果没有啥特殊想法，可以设置为系统内存一半。

## 修改环境变量

如果需要添加环境变量，在 /etc/elasticsearch/env 里添加

## 添加插件

如果需要其他插件，将文件夹 copy 到 ./plugins/  下

## 修改数据文件目录

ES 需要2个数据文件目录，需要在 docker compose-yaml 里修改
1. 索引数据 默认在  /app/elasticsearch/data
1. 日志文件 默认在  /app/elasticsearch/logs


## 启动 ElasticSearch

./run.sh start
