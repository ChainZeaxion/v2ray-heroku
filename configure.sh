#!/bin/sh
# Download and install V2Ray
curl -L -H "Cache-Control: no-cache" -o /v2ray.zip https://github.com/v2ray/v2ray-core/releases/latest/download/v2ray-linux-64.zip
mkdir /usr/bin/v2ray /etc/v2ray
touch /etc/v2ray/config.json
unzip /v2ray.zip -d /usr/bin/v2ray
# Remove /v2ray.zip and other useless files
rm -rf /v2ray.zip /usr/bin/v2ray/*.sig /usr/bin/v2ray/doc /usr/bin/v2ray/*.json /usr/bin/v2ray/*.dat /usr/bin/v2ray/sys*
# V2Ray new configuration
cat <<-EOF > /etc/v2ray/config.json

{
  "inbounds": [
    {
      "port": 1080,
      "listen": "127.0.0.1",
      "protocol": "socks",
      "sniffing": {
        "enabled": true,
        "destOverride": ["http", "tls"]
      },
      "settings": {
        "auth": "noauth",
        "udp": false,
        "userLevel": 999
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "vmess",
      "settings": {
        "vnext": [
          {
            "address": "zeaxion-app.herokuapp.com",
            "port": 443,
            "users": [
              {
                "id": "9ce741b7-f27e-4d41-8510-a4994e8ee727",
                "security": "auto",
                "connectionReuse": true,
                "path": "/wbst/",
                "alterId": 64
              }
            ]
          },
          {
            "address": "zeaxion-app1.herokuapp.com",
            "port": 443,
            "users": [
              {
                "id": "9ce741b7-f27e-4d41-8510-a4994e8ee727",
                "security": "auto",
                "connectionReuse": true,
                "path": "/wbst/",
                "alterId": 64
              }
            ]
          }
        ]
      },
      "streamSettings": {
        "network": "ws",
        "security": "tls"
      }
    }
  ]
}

EOF
/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
