FROM v2fly/v2fly-core

COPY ./v2ray-server.json /etc/v2ray/config.json
EXPOSE 10000
ENTRYPOINT [ "/usr/bin/v2ray", "run", "--config=/etc/v2ray/config.json" ]
