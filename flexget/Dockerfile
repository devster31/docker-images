FROM lsiobase/alpine.armhf

COPY qemu-arm-static /usr/bin/
# Resin-xbuild
COPY resin-xbuild /usr/bin/
RUN ln -s resin-xbuild /usr/bin/cross-build-start && \
    ln -s resin-xbuild /usr/bin/cross-build-end

# set version label
#ARG BUILD_DATE
#ARG VERSION
#LABEL build_version="Linuxserver.io version:- ${VERSION} Build-date:- ${BUILD_DATE}"

ENV \
    XDG_CONFIG_HOME="/config/xdg" \
    XDG_DATA_HOME="/config/local/share"

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"

RUN [ "cross-build-start" ]

# install build packages
RUN set -eu \
    apk --update upgrade && \
    apk del python3* && \
    echo 'http://dl-cdn.alpinelinux.org/alpine/v3.5/main/' >> /etc/apk/repositories && \
    apk add --no-cache \
      git \
      python3=3.5.2-r9 \
    && python3 -m ensurepip --upgrade \
    && pip3 install -U pip setuptools \
    && git clone https://github.com/Flexget/Flexget.git /app/flexget

WORKDIR /app/flexget

RUN pip3 install -e .

ENV EDITOR="nano" \
HOME="/config"

# copy local files
COPY root/ /
RUN mkdir /config/.flexget

RUN [ "cross-build-end" ]

# ports and volumes
EXPOSE 5050
VOLUME /config
