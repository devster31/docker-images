#!/bin/sh
# original can be found https://github.com/filebot/filebot/blob/master/installer/portable/filebot.sh

# make sure required environment variables are set
if [ -z "$USER" ]; then
	export USER=`whoami`
fi

# force JVM language and encoding settings
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# choose extractor
EXTRACTOR="ApacheVFS"					# use Apache Commons VFS2 with junrar plugin
# EXTRACTOR="SevenZipExecutable"		# use the 7z executable
# EXTRACTOR="SevenZipNativeBindings"	# use the lib7-Zip-JBinding.so native library

# start filebot
java \
    -Dunixfs=false \
    -DuseGVFS=false \
    -DuseExtendedFileAttributes=true \
    -DuseCreationDate=false \
    -Djava.net.useSystemProxies=false \
    -Dapplication.deployment=docker \
    -Dfile.encoding="UTF-8" \
    -Dsun.jnu.encoding="UTF-8" \
    -Djna.nosys=false \
    -Djna.nounpack=true \
    -Dnet.filebot.Archive.extractor="$EXTRACTOR" \
    -Dnet.filebot.AcoustID.fpcalc="fpcalc" \
    -Dapplication.dir="$CONF_PATH" \
    -Duser.home="$CONF_PATH" \
    -Djava.io.tmpdir="$CONF_PATH/tmp" \
    -Djava.util.prefs.PreferencesFactory=net.filebot.util.prefs.FilePreferencesFactory \
    -Dnet.filebot.util.prefs.file="$CONF_PATH/prefs.properties" \
    $JAVA_OPTS -jar "/app/FileBot.jar" "$@"
