#!/bin/bash
set -e
set -o pipefail

QEMU_VERSION='2.9.0.resin1-arm'
QEMU_SHA256='b39d6a878c013abb24f4cccc7c3a79829546ae365069d5712142a4ad21bcb91b'
RESIN_XBUILD_VERSION='1.0.0'
RESIN_XBUILD_SHA256='1eb099bc3176ed078aa93bd5852dbab9219738d16434c87fc9af499368423437'

# Download QEMU
curl -SLO https://github.com/resin-io/qemu/releases/download/v2.9.0+resin1/qemu-$QEMU_VERSION.tar.gz \
	&& echo "$QEMU_SHA256  qemu-$QEMU_VERSION.tar.gz" | sha256sum -c - \
	&& tar -xz --strip-components=1 -f qemu-$QEMU_VERSION.tar.gz
curl -SLO http://resin-packages.s3.amazonaws.com/resin-xbuild/v$RESIN_XBUILD_VERSION/resin-xbuild$RESIN_XBUILD_VERSION.tar.gz \
	&& echo "$RESIN_XBUILD_SHA256  resin-xbuild$RESIN_XBUILD_VERSION.tar.gz" | sha256sum -c - \
	&& tar -xzf resin-xbuild$RESIN_XBUILD_VERSION.tar.gz
chmod +x qemu-arm-static resin-xbuild
