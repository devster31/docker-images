#!/usr/bin/with-contenv bash
umask 022

JAVA_OPTS=${JAVA_OPTS:-" -Xmx256m"}

exec s6-setuidgid abc /usr/bin/java -Djava.awt.headless=true ${JAVA_OPTS} -jar /app/jd2/JDownloader.jar -console 2>/dev/null
