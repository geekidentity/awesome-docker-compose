# 主从版数据库搭建

## master 服务器配置

### 修改配置文件

1. 将 ./postgresql-master/etc 下的 pg_hba.conf pg_ident.conf postgresql.conf 复制到 /etc/postgresql/ 下

2. 修改 pg_hba.conf 配置

把Master库和Standby库的IP地址添加进Master库网络策略白名单中，使Standby库可以连上Master库，同时便于主备切换。

```
host  replication   replicator   10.19.100.2/32      md5
host  replication   replicator   10.19.100.3/32      md5
```

3. 修改 postgresql.conf 配置

在原配置文件postgresql.conf的基础上修改,修改内容如下：
```
wal_level= logical
max_wal_senders = 10  # at least the number of standby
archive_mode = on
archive_command = 'if [ ! -d /var/lib/postgresql-archive/ ]; then mkdir -p /var/lib/postgresql-archive/; echo "mkdir" ; fi; cp %p /var/lib/postgresql-archive/%f'
synchronous_standby_names = ''  #standby application name, in recover.conf
hot_standby=on
```

### 启动服务

1. 配置完成后启动PostgreSQL，初始化脚本会自动创建用户名为replicator密码为Aa123456的用户及用户名为smartlink密码为Aa123456的用户。同时初始化脚本会把所有数据库、表结构和初始化数据创建好。

## Slave 服务器配置

### 修改配置文件

1. 将 ./postgresql-standby/etc 下的 pg_hba.conf pg_ident.conf postgresql.conf 复制到 /etc/postgresql/ 下

2. 修改 postgresql.conf 配置

在原配置文件postgresql.conf的基础上修改,修改内容如下（和主库一样）：
```
wal_level= logical
max_wal_senders = 10  # at least the number of standby
archive_mode = on
archive_command = 'if [ ! -d /var/lib/postgresql-archive/ ]; then mkdir -p /var/lib/postgresql-archive/; echo "mkdir" ; fi; cp %p /var/lib/postgresql-archive/%f'
synchronous_standby_names = ''  #standby application name, in recover.conf
hot_standby=on
```

3. 从库同步主库数据

```
docker run -it --name get_pg_master -v /app/postgresql-data:/var/lib/postgresql/data  postgres:10.8-alpine /bin/bash -c "pg_basebackup -F p --progress -D /var/lib/postgresql/data -h <master-ipaddr> -p 5432 -U replicator --password"

```

输入密码：Aa123456  完成同步。

把recovery.conf文件放入/app/postgresql-data下，

recovery.conf内容如下：

```
standby_mode = on   #表示该节点是从库
primary_conninfo = 'host=<master-ipaddr> port=5432 user=replicator password=Aa123456'
recovery_target_timeline = 'latest' #说明恢复到最新状态
```

4. 配置完成后启动PostgreSQL
   
进入PG中执行SQL查看主从状态select pg_is_in_recovery()。