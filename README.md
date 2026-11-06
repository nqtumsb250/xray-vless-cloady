# xray-vless-cloady

Private xray VLESS + WebSocket service deployed on Cloady (region usw1, free tier).

- Multi-stage Dockerfile: the xray binary is copied from the official
  `ghcr.io/xtls/xray-core` image (which has no shell) into `alpine:latest`;
  the runtime image is Alpine.
- xray listens on port 3000 inside the container; Cloady exposes it on
  public HTTPS port 443.
- Protocol: VLESS over WebSocket + TLS. The UUID and WebSocket path are
  configured in `config.json`.
