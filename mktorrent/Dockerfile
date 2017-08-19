FROM alpine

ARG VERSION

ENV pkgver="$VERSION"

LABEL \
    org.label-schema.name="mktorrent" \
    org.label-schema.vcs-url="https://github.com/Rudde/mktorrent" \
    org.label-schema.version="$VERSION" \
    org.label-schema.schema-version="1.0.0-rc.1" \
    org.label-schema.docker.cmd="docker run -it --rm -v $HOME:/artifacts alpine sh -l" \
    # creates the static binary in a bin sub-folder
    org.label-schema.docker.params="pkgver=version of mktorrent" \

    org.label-schema.description="Simple command line utility to create BitTorrent metainfo files" \
    org.label-schema.license="GPL"

# source=("$pkgname-$pkgver.tar.gz::https://github.com/Rudde/mktorrent/archive/v$pkgver.tar.gz")

RUN apk add --update --no-cache \
        curl \
#         git \
        g++ \
        make \
    && \
#     git clone https://github.com/Rudde/mktorrent.git && \
    curl -sSL https://github.com/Rudde/mktorrent/archive/v$pkgver.tar.gz | tar -xzvf- && \
    cd mktorrent-$pkgver && \
    make PREFIX=/artifacts \
        CFLAGS='-O2 -Wall -static' USE_PTHREADS=1 USE_LONG_OPTIONS=1 USE_LARGE_FILES=1 \
        install

VOLUME /artifacts
