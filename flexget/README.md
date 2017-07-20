# FlexGet

Official website: [FlexGet](https://www.flexget.com/)

This directory requires the entire FlexGet code from GitHub and it uses submodules to achieve it. For more information on usage of submodules [here](https://github.com/blog/2104-working-with-submodules) is a link.

This is a work in progress and in particular it will require correct user permissions to avoid conflicts if you decide to mount your own configuration.

Instructions:
```sh
VERSION=$(curl -sSL https://raw.githubusercontent.com/Flexget/Flexget/develop/flexget/_version.py | awk 'BEGIN {FS="[=]"} /__version__/{gsub(/^[[:space:]]+|[[:space:]]+$/, "", $2); gsub(/\x27/, "", $2);print $2}')
docker build --tag flexget:rpi3 --build-args=BUILD_DATE="$(date -u +%B-%d-%Y-%H:%M:%S-%Z)" .

docker run \
  --name=flexget \
  -e PUID=`id -u` -e PGID=`id -g` \
  -e TZ='Europe/Rome' \
  -p 5050:5050 \
  -v </path/to/flexgetdir>:/config \
  flexget
```
The port is the same as couchpotato, but you can map it to something else on the host.
Another alternative is to run this container with `--network='host'` option and just let it use the host network stack.

An additional parameter can be used to install additional pip packages:
```sh
docker run \
  --name=flexget \
  -e PIP_EXTRA="transmissionrpc subliminal" \
  -e PUID=`id -u` -e PGID=`id -g` \
  -e TZ='Europe/Rome' \
  -p 5050:5050 \
  -v </path/to/flexgetdir>:/config \
  flexget
```
