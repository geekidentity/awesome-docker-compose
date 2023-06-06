
安装https://www.home-assistant.io/installation/linux#docker-compose

配置frp内网穿透需要修改配置文件

在home assistant 安装目录中，修改 configuration.yaml，添加如下代码

```yaml
http:
  server_port: 8123  
  cors_allowed_origins:  
    - https://xxx.com
  use_x_forwarded_for: true
  trusted_proxies:
    - your ip // 提供服务的内网ip
    - 172.18.0.0/24  //add this if use docker 如果你用docker 添加这个
  ip_ban_enabled: true
  login_attempts_threshold: 5
```