FROM openjdk:8-jdk as java
# FROM resin/raspberrypi3-alpine-openjdk

ENV \
    ANT_HOME=/app/ant \
    ANT_VERSION=1.10.1 \
    IVY_VERSION=2.4.0 \
    JAVA_XZ_VERSION=1.6 \
    GNUPGHOME=/tmp/gpg \
    PATH=/app/ant/bin:$PATH

RUN DEBIAN_FRONTEND=noninteractive \
    apt-get update -q && \
    apt-get install -qy --no-install-recommends \
        apt-utils \
        openjfx && \

    mkdir -p /app/ant /app/ivy /tmp/gpg && \
    curl https://www.apache.org/dist/ant/KEYS | gpg --import && \
    cd /tmp && \
    curl -SL -O http://it.apache.contactlab.it//ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz && \
    curl -SL https://www.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz.asc | gpg --verify - apache-ant-${ANT_VERSION}-bin.tar.gz && \
    mkdir -p /app/ant && \
    tar -C /app/ant --strip-components=1 -xvf apache-ant-${ANT_VERSION}-bin.tar.gz && \

    curl -SL -O http://it.apache.contactlab.it//ant/ivy/${IVY_VERSION}/apache-ivy-${IVY_VERSION}-bin.tar.gz && \
    curl -SL http://www.apache.org/dist/ant/ivy/${IVY_VERSION}/apache-ivy-${IVY_VERSION}-bin.tar.gz.asc | gpg --verify - apache-ivy-${IVY_VERSION}-bin.tar.gz && \
    tar -C /app/ivy --strip-components=1 -xvf apache-ivy-${IVY_VERSION}-bin.tar.gz && \
    cp /app/ivy/ivy-${IVY_VERSION}.jar ${ANT_HOME}/lib && \

    curl -SL -o $JAVA_HOME/jre/lib/ext/xz-1.6.jar https://search.maven.org/remotecontent?filepath=org/tukaani/xz/1.6/xz-1.6.jar

RUN git clone https://github.com/filebot/filebot.git /app/filebot
WORKDIR /app/filebot

RUN ant resolve fatjar portable

##################################################

# FROM buildpack-deps:stretch-scm as mediainfo
FROM alpine as mediainfo
ENV \
    ZENLIB_VERSION=0.4.36 \
    LIBMEDIAINFO_VERSION=0.7.98 \
    MEDIAINFO_VERSION=0.7.98

# RUN DEBIAN_FRONTEND=noninteractive \
#     apt update -q && \
#     apt install -qy --no-install-recommends \
#         autoconf \
#         automake \
#         g++ \
#         libcurl4-gnutls-dev \
#         libglib2.0-dev \
#         libmms-dev \
#         libtool \
#         make \
#         pkg-config \
#         zlib1g-dev

RUN apk add --update --no-cache \
        autoconf \
        automake \
        curl \
        curl-dev \
        g++ \
        git \
        glib-dev \
        libmms-dev \
        libtool \
        make \
        pkgconfig \
        zlib-dev

RUN \
    mkdir -p /app/ZenLib /app/MediaInfoLib /app/MediaInfo && \
    curl -SL https://github.com/MediaArea/ZenLib/archive/v${ZENLIB_VERSION}.tar.gz | tar -C /app/ZenLib --strip-components=1 -xzvf - && \
    curl -SL https://github.com/MediaArea/MediaInfoLib/archive/v${LIBMEDIAINFO_VERSION}.tar.gz | tar -C /app/MediaInfoLib --strip-components=1 -xzvf - && \
    curl -SL https://github.com/MediaArea/MediaInfo/archive/v${MEDIAINFO_VERSION}.tar.gz | tar -C /app/MediaInfo --strip-components=1 -xzvf - && \
    cd /app/ZenLib/Project/GNU/Library && ./autogen.sh && ./configure --enable-static && make install-strip && \
    cd /app/MediaInfoLib/Project/GNU/Library && ./autogen.sh && ./configure --enable-static --with-libcurl --with-libmms && make install-strip && \
    cd /app/MediaInfo/Project/GNU/CLI && ./autogen.sh && ./configure --enable-staticlibs --disable-shared && make install-strip

##################################################

FROM lsiobase/alpine
ENV \
    ZENLIB_VERSION=0.4.36 \
    LIBMEDIAINFO_VERSION=0.7.98 \
    MEDIAINFO_VERSION=0.7.98 \
    FILEBOT_VERSION=4.7.12 \
    CONF_PATH=/config

# missing libraries
COPY --from=mediainfo /usr/local/bin/mediainfo /usr/local/bin/mediainfo
COPY --from=mediainfo /usr/local/lib/*.so.0.0.0 /usr/local/lib/

COPY --from=java /app/filebot/dist/FileBot_${FILEBOT_VERSION}.jar /app/FileBot.jar
# COPY --from=java /app/filebot/dist/FileBot_${FILEBOT_VERSION}-portable.tar.xz /tmp

RUN ln -s /usr/local/lib/libmediainfo.so.0.0.0 /usr/local/lib/libmediainfo.so.0 && \
    ln -s /usr/local/lib/libmediainfo.so.0 /usr/local/lib/libmediainfo.so && \
    ln -s /usr/local/lib/libzen.so.0.0.0 /usr/local/lib/libzen.so.0 && \
    ln -s /usr/local/lib/libzen.so.0 /usr/local/lib/libzen.so

ADD filebot.sh /usr/local/bin/filebot

RUN chmod +x /usr/local/bin/filebot
# RUN mkdir -p /app && \
#     tar -C /app -xvf /tmp/FileBot_${FILEBOT_VERSION}-portable.tar.xz && \
#     ln -s /app/filebot.sh /usr/local/bin/filebot

RUN apk add --update --no-cache \
        curl \
        libmms \
        java-jna-native \
        openjdk8-jre && \

    apk add --update --no-cache \
        --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing \
        chromaprint

VOLUME /config /media
