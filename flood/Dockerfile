FROM alpine as mediainfo

ARG MEDIAINFO_VERSION

ENV MEDIAINFO_VERSION="$MEDIAINFO_VERSION"

RUN apk add --update --no-cache --virtual .build-dependencies \
        curl \
        file \
        g++ \
        gcc \
        git \
        make \
        tar \
        xz \
     && \
    curl -sSL https://mediaarea.net/download/binary/mediainfo/${MEDIAINFO_VERSION}/MediaInfo_CLI_${MEDIAINFO_VERSION}_GNU_FromSource.tar.xz | tar -xJvf- -C /tmp && \
    cd /tmp/MediaInfo_CLI_GNU_FromSource && \
    ./CLI_Compile.sh && \
    cd MediaInfo/Project/GNU/CLI && make install

##################################################

FROM node:alpine

ARG NODE_ENV
ARG VERSION

ENV \
    NODE_ENV="$NODE_ENV" \
    FLOOD_VERSION="$VERSION"

LABEL \
    org.label-schema.name="flood" \
    org.label-schema.vcs-url="https://github.com/jfurrow/flood" \
    org.label-schema.version="$VERSION" \
    org.label-schema.schema-version="1.0.0-rc.1"

COPY --from=mediainfo /usr/local/bin/mediainfo /usr/local/bin/mediainfo

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN \
    apk add --update --no-cache \
        git \
        libgcc \
        libstdc++ \
    && \
    git clone --quiet https://github.com/jfurrow/flood.git /usr/src/app && \
    if [ ${FLOOD_VERSION} != 'master' ]; \
    then \
        git checkout --quiet tags/${FLOOD_VERSION}; \
    fi && \
    npm install --porcelain --quiet && npm cache clean --force && \
    cp /usr/src/app/config.docker.js /usr/src/app/config.js

EXPOSE 3000

VOLUME [ "/data" ]

CMD [ "npm", "start" ]
