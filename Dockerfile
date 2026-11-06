# syntax=docker/dockerfile:1
# Multi-stage build: copy the xray binary out of the official
# xray image (ghcr.io/xtls/xray-core, which has no shell) into
# Alpine, and run it there. The runtime image is Alpine, not the
# official xray image.
# The xray config is generated at container start by entrypoint.sh
# from the UUID and WS_PATH environment variables, so no credentials
# are stored in this repository.
FROM ghcr.io/xtls/xray-core:26.10.31 AS xray
FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]
