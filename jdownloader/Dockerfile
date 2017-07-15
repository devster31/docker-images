FROM lsiobase/alpine.armhf

ARG JDOWNLOADER_URL="http://installer.jdownloader.org/JDownloader.jar"

RUN apk --no-cache --update add \
      curl \
      openjdk8-jre \
    && mkdir -p /app/jd2 && cd /app/jd2 \
    && curl -sSL ${JDOWNLOADER_URL} -O \
    && java -Djava.awt.headless=true -jar /app/jd2/JDownloader.jar -norestart 2>/dev/null

ADD root/ /
RUN chmod +x /usr/local/bin/jd
WORKDIR /app
VOLUME /app /config /downloads
