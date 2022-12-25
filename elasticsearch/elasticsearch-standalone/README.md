# ElasticSearch 安装

注：ES 的安装需要 root 权限

##前期准备

需要将ES的docker镜像 load 到服务器上。

默认使用 bridge 网络模式，如果需要在多个宿主机上部署ES，建议使用 host 网络模式。

## 初始化

执行 init.sh 脚本初始化系统环境

## 添加插件

如果需要其他插件，将文件夹 copy 到 /app/elasticsearch/plugins/  下

## 修改数据文件目录

ES 需要2个数据文件目录，需要在 docker-compose-yaml 里修改
1. 索引数据 默认在  /app/elasticsearch/data
1. 日志文件 默认在  /app/elasticsearch/logs


## 启动 ElasticSearch

./run.sh start
