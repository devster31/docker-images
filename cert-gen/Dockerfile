FROM lsiobase/alpine.armhf

ENV DOCKER_HOST unix:///tmp/docker.sock
ENV CERTBOT_SLEEP 1d

RUN apk --no-cache --update add \
        ca-certificates \
        curl \
        python \
        zlib \
    && curl -SL -o get-pip.py 'https://bootstrap.pypa.io/get-pip.py' \
    && python get-pip.py \
        --disable-pip-version-check \
        --no-cache-dir \
    && find /usr/local -depth \
        \( \
            \( -type d -a \( -name test -o -name tests \) \) \
            -o \
            \( -type f -a \( -name '*.pyc' -o -name '*.pyo' \) \) \
        \) -exec rm -rf '{}' + \
    && rm -f get-pip.py \
    && apk add --no-cache --virtual .certbot-deps \
        binutils \
        libffi \
        openssl \
    && apk add --no-cache --virtual .build-deps \
        gcc \
        libffi-dev \
        linux-headers \
        musl-dev \
        openssl-dev \
        python-dev \
    && pip install certbot \
    && apk del .build-deps

RUN apk --no-cache --update --virtual .go-build-deps add \
        git \
        go \
        musl-dev \
    && export GOPATH=/app \
    && go get -d -u -v github.com/jwilder/docker-gen \
    && go get -v github.com/robfig/glock \
    && ${GOPATH}/bin/glock sync -n < ${GOPATH}/src/github.com/jwilder/docker-gen/GLOCKFILE \
    && pushd ${GOPATH}/src/github.com/jwilder/docker-gen \
    && export TAG=$(git describe --tags) \
    && popd \
    && export LDFLAGS="-X main.buildVersion=${TAG}" \
    && go install -v -ldflags "${LDFLAGS}" -a \
        github.com/jwilder/docker-gen/cmd/docker-gen \
    && mv /app/bin/docker-gen /usr/local/bin/docker-gen \
    && rm -rf /app/* \
    && apk del .go-build-deps

# ENV DOCKER_GEN_VERSION 0.7.3
# ENV DOCKER_GEN_DOWNLOAD_URL https://github.com/jwilder/docker-gen/releases/download/$DOCKER_GEN_VERSION/docker-gen-alpine-linux-amd64-$DOCKER_GEN_VERSION.tar.gz
# RUN curl -SL $DOCKER_GEN_DOWNLOAD_URL | tar xvz -C /usr/local/bin

ADD root.dockergen /

EXPOSE 80 443
VOLUME /etc/letsencrypt /var/lib/letsencrypt /etc/docker-gen
