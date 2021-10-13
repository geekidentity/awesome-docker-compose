
mysql用户访问docker中的目录时, 会报权限错误!。
因为 本地映射目录的主人是root用户, 
而docker容器中/var/lib/mysql目录的主人是mysql用户,uid为999。
```bash
chown 999:999 -R /app/mysql
```
或
```bash
chmod 777 -R /app/mysql
```

参考：
1. https://github.com/treetips/docker-compose-all-mysql