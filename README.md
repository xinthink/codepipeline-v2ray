## V2ray websocket + TLS，服务端 + 客户端, Docker Compose脚本

websocket + tls 更安全， 通过`docker-compose`启动，脚本简单易维护。

- 配置参考了[新V2Ray白话文指南的WebSocket + TLS + Web](https://guide.v2fly.org/advanced/wss_and_web.html)，
- [Caddy](https://hub.docker.com/_/caddy), [v2ray](https://hub.docker.com/r/v2fly/v2fly-core)全采用官方lastest镜像，性能可靠，安全易维护。
- Caddy自动获取证书
- 使用[Golang的模板引擎gomplate](https://docs.gomplate.ca/installing/#use-with-docker), 去渲染配置文件。

前提准备：
1.  有一台服务器，对外开放80，443端口，有一个域名解析到该服务器
2.  本地电脑已安装[docker-compose](https://docs.docker.com/compose/install/)

## 运行步骤

1.  把`.env`文件里的DOMAIN变量改成你的域名
2.  把`.env`文件里的UUID变量修改为新的随机数, 可以使用[Online UUID Generator](https://www.uuidgenerator.net/)
3.  运行`gomplate.sh`脚本，把`templates`文件夹里的配置文件， 根据`.env`的变量，生成`Caddyfile`, `v2ray-server.json`, `v2ray-client.json`
4.  在服务器， 运行`docker-compose up -d`, 启动`v2ray`和`caddy`服务。
5.  在本地电脑， 运行`docker-compose -f docker-compose.client.yaml up -d`, 启动`v2ray-client`服务，本地socks代理端口`1080`和http代理端口`1081`。大功告成🚀


>    注意区别：服务端的脚本是`docker-compose.yaml`, 客户端的脚本是`docker-compose.client.yaml`

## 模板渲染脚本简介

## 服务端脚本简介

Docker Compose启动：

```bash
docker-compose up -d
```

在当前目录下查看日志

```bash
docker-compose logs -f
```

如果本地电脑是ubuntu系统，可以用`rsync`命令， 把仓库拷贝到远程服务器, 例如：（remote地址已经在.ssh/config配置好）

```bash
rsync -avzP -e ssh --exclude .git  .  remote:/home/ubuntu/v2ray-docker-compose
```

## 客户端脚本简介

Docker Compose启动：

```bash
docker-compose -f docker-compose.client.yaml up -d
```

Docker Compose停止：

```bash
docker-compose -f docker-compose.client.yaml down
```

或者执行以下docker命令

```bash
docker run -d -p 1080:1080 -p 1081:1081 --volume=${PWD}/v2ray-client.json:/etc/v2ray/config.json --restart=unless-stopped --name=v2ray-client v2fly/v2fly-core v2ray --config=/etc/v2ray/config.json
```

或者运行`start_client.sh`脚本，脚本内容就是上面的命令
