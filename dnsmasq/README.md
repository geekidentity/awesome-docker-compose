在安装时，可能会显示53端口已经被占用了，很多Linux默认会启动DNS服务，可以查看对应端口是否占用

以Qnap NAS为例，可以看到一个/sbin/dnsmasq的进程
```shell
ps -ef|grep dnsmasq
```

dnsmasq 配置文件为/etc/dnsmasq.conf ，但NAS重启后被重置，因此使用Docker 进行部署。

# 配置文件
1. /etc/dnsmasq.conf
核心配置文件，只修改以下三项，默认banner_add_hosts没有创建。listen-address补充上实际的对外IP地址。
```
listen-address=10.0.3.1,10.8.0.1,192.168.1.10,127.0.1.1,10.0.5.1,10.0.7.1
addn-hosts=/etc/banner_add_hosts
resolv-file=/etc/resolv.dnsmasq
```
2. /etc/resolv.dnsmasq
```
nameserver 114.114.114.114
nameserver 8.8.8.8
```
3. /etc/banner_add_hosts
```
192.168.1.10 nas.xxlab.tech
```