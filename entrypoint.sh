#!/bin/sh
# Generate the xray config at container start from environment
# variables, so no credentials are stored in this repository.
# Required environment variables:
#   UUID    - VLESS client UUID
#   WS_PATH - WebSocket path, e.g. /vless-ws-xxxx
set -eu

: "${UUID:?UUID environment variable is required}"
: "${WS_PATH:?WS_PATH environment variable is required}"

mkdir -p /etc/xray

cat > /etc/xray/config.json <<EOF
{
  "log": {
    "loglevel": "warning"
  },
  "inbounds": [
    {
      "port": 3000,
      "listen": "0.0.0.0",
      "protocol": "vless",
      "settings": {
        "clients": [
          {
            "id": "$UUID",
            "flow": ""
          }
        ],
        "decryption": "none"
      },
      "streamSettings": {
        "network": "ws",
        "wsSettings": {
          "path": "$WS_PATH"
        }
      }
    }
  ],
  "outbounds": [
    {
      "protocol": "freedom",
      "tag": "direct"
    }
  ]
}
EOF

exec /usr/local/bin/xray run -c /etc/xray/config.json
