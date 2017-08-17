FROM node

ARG NODE_ENV
ARG version

ENV \
    NODE_ENV="$NODE_ENV" \
    FLOOD_VERSION="$version"

LABEL \
    org.label-schema.name="flood" \
    org.label-schema.vcs-url="https://github.com/jfurrow/flood" \
    org.label-schema.version="$version" \
    org.label-schema.schema-version="1.0.0-rc.1"

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

RUN \
    DEBIAN_FRONTEND=noninteractive \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        mediainfo \
    && \
    rm -rf /var/lib/apt/lists/* \
    && \
    git clone https://github.com/jfurrow/flood.git /usr/src/app && \
    if [ ${FLOOD_VERSION} != 'master' ]; \
    then \
        git checkout tags/${FLOOD_VERSION}; \
    fi && \
    cp /usr/src/app/config.docker.js /usr/src/app/config.js && \
    npm install --porcelain --quiet && npm cache clean --force

EXPOSE 3000

VOLUME [ "/data" ]

CMD [ "npm", "start" ]
