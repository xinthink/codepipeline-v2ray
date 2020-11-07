#!/bin/bash
docker run -d -p 1080:1080 -p 1081:1081 \
    --volume=${PWD}/v2ray-client.json:/etc/v2ray/config.json \
    --restart=unless-stopped --name=v2ray-client  \
    v2fly/v2fly-core v2ray --config=/etc/v2ray/config.json
