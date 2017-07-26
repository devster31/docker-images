FROM lsiobase/alpine.armhf

ARG JDOWNLOADER_URL="http://installer.jdownloader.org/JDownloader.jar"

ADD root/ /

RUN set -eu \
    apk --no-cache --update add \
      curl \
      openjdk8-jre \
    && mkdir -p /app/jd2 && cd /app/jd2 \
    && curl -sSL ${JDOWNLOADER_URL} -O \
    && java -Djava.awt.headless=true -jar /app/jd2/JDownloader.jar -norestart 2>/dev/null \
    && chmod +x /usr/local/bin/jd

WORKDIR /app
VOLUME /app /config /downloads
