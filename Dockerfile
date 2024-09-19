FROM alpine:3.20.3

RUN apk add --no-cache \
        bash \
        bind-tools \
        iptables \
        openvpn \
        nftables \
        shadow

COPY data/ /data/

ENV KILL_SWITCH=iptables
ENV USE_VPN_DNS=on
ENV VPN_LOG_LEVEL=3

ARG BUILD_DATE
ARG IMAGE_VERSION

LABEL build-date=$BUILD_DATE
LABEL image-version=$IMAGE_VERSION

HEALTHCHECK CMD ping -c 3 1.1.1.1 || exit 1

WORKDIR /data

ENTRYPOINT [ "scripts/entry.sh" ]
