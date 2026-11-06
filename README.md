# xray-vless-cloady

Private xray VLESS + WebSocket service deployed on Cloady (region usw1, free tier).

- Multi-stage Dockerfile: the xray binary is copied from the official `ghcr.io/xtls/xray-core` image (which has no shell) into `alpine:latest`; the runtime image is Alpine.
- xray listens on port 3000 inside the container; Cloady exposes it on public HTTPS port 443.
- Protocol: VLESS over WebSocket + TLS. The UUID and WebSocket path are supplied at container start through the `UUID` and `WS_PATH` environment variables (set in the Cloady service); no credentials are stored in this repository. `entrypoint.sh` generates the xray config from them when the container starts.
