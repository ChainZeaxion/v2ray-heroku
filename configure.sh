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

cat <<-EOF > /etc/v2ray/config.json
#    "port": ${PORT},
{
  "inbounds": [
    {
      "protocol": "vmess",
      "port": "32310-33200",
      "tag": "dynamicPort-3443",
      "settings": {
        "default": {
          "alterId": 64
        }
      },
      "allocate": {
        "strategy": "random",
        "concurrency": 4,
        "refresh": 2
      }
    },
    {
      "port": 4443,
      "protocol": "vmess",
      "settings": {
        "clients": [
          {
            "id": "9ce741b7-f27e-4d41-8510-a4994e8ee727",
            "alterId": 64
          }
        ],
        "detour": {
          "to": "dynamicPort-3443"
        }
      },
      "streamSettings": {
        "network": "ws",
        "security": "auto",
        "tlsSettings": {},
        "tcpSettings": {},
        "kcpSettings": {},
        "httpSettings": {},
        "wsSettings": {
          "connectionReuse": true,
          "path": "/wbst/",
          "headers": {
            "Host": ""
          }
        },
        "quicSettings": {},
        "sockopt": {
          "mark": 0,
          "tcpFastOpen": true
        }
      }
    }
  ],
  "outbounds": [
  {
    "protocol": "freedom",
    "settings": {}
  }
  ]
}

EOF
/usr/bin/v2ray/v2ray -config=/etc/v2ray/config.json
