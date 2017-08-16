#!/bin/sh -u
# original can be found https://github.com/filebot/plugins/blob/master/docker/filebot-watcher

# inotify
# -m, --monitor
# 	Instead of exiting after receiving a single event, execute indefinitely.
# 	The default behaviour is to exit after the first event occurs.
# -e <event>, --event <event>
# 	Listen for specific event(s) only. The events which can be listened for are
# 	listed in the EVENTS section. This option can be specified more than once.
# 	If omitted, all events are listened for.
# --format <fmt>
# 	Output in a user-specified format, using printf-like syntax. The event strings
# 	output are limited to around 4000 characters and will be truncated to this length.
# 	The following conversions are supported:
# 	%w - This will be replaced with the name of the Watched file on which an event occurred.
# 	%f - When an event occurs within a directory, this will be replaced with the name of the File which caused the event to occur. Otherwise, this will be replaced with an empty string.
# 	%e - Replaced with the Event(s) which occurred, comma-separated.
# 	%Xe - Replaced with the Event(s) which occurred, separated by whichever character is in the place of 'X'.
# 	%T - Replaced with the current Time in the format specified by the --timefmt option, which should be a format string suitable for passing to strftime(3).
#
# stdbuf
# -o, --output=MODE		Adjust standard output stream buffering
# If MODE is 'L' the corresponding stream will be line buffered. This option is invalid with standard input.
#
# read
# -r		do not allow backslashes to escape any characters
inotifywait -m "$1" -e close_write --exclude '/[.@]' --format '%w%f' | stdbuf -oL uniq | while read -r FILE; do
	# e.g. video.mp4: video/mp4
	if file --mime-type "$FILE" | egrep "directory|video|audio|empty|octet-stream"; then
		filebot -script fn:amc --action duplicate --conflict auto -non-strict --log-file amc.log --def excludeList=".excludes" unsorted=y music=y artwork=y "$@"
	fi
done
