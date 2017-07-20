# ZNC buildmod container

Based on `linuxserver/znc` this container has the sole purpose of allowing an easier build of mods.

```sh
docker build --tag=znc-buildmod .
docker run -it --rm \
  --name=znc-buildmod \
  --volumes-from=<znc container> \
  -e PUID=`id -u` -e PGID=`id -g` \
  -e TZ=<timezone> \
  znc-buildmod \
  /bin/bash
```
Once logged in you might want to install additional packages, as root, or `su` as `abc` (the default user) to build your module.
The command is `su -s /bin/bash - abc`.

After building the module you can copy it to the `/config` directory.
