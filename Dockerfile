# syntax=docker/dockerfile:1
# Multi-stage build: copy the xray binary out of the official
# xray image (ghcr.io/xtls/xray-core, which has no shell) into
# Alpine, and run it there. The runtime image is Alpine, not the
# official xray image.
FROM ghcr.io/xtls/xray-core:26.10.31 AS xray
FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY config.json /etc/xray/config.json
EXPOSE 3000
ENTRYPOINT ["/usr/local/bin/xray"]
CMD ["run", "-c", "/etc/xray/config.json"]
