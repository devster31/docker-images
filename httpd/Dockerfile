FROM httpd:alpine

ARG OVERLAY_VERSION="v1.21.4.0"
ARG OVERLAY_ARCH="amd64"

ADD https://github.com/just-containers/s6-overlay/releases/download/${OVERLAY_VERSION}/s6-overlay-${OVERLAY_ARCH}.tar.gz /tmp/s6-overlay.tar.gz
RUN tar xzf /tmp/s6-overlay.tar.gz -C /

RUN apk add --no-cache \
        bash \
        ca-certificates \
        coreutils \
        curl \
        lynx \
        shadow \
        tar \
        tzdata \
    && \
    usermod --home /config --move-home www-data \
    && \
    rm -rf /tmp/*

COPY root/ /

ENTRYPOINT ["/init"]