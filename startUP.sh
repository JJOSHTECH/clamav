#!/bin/bash

# Update Antivirus Database
freshclam

#Include cronjob into crontab
crontab /etc/cron.d/cronjob

# set ClamAV env
COMMAND="clamd --foreground=true"

# Starting Container
echo "Starting container .."
if [ "$@" = "clamav" ]; then
	echo "Executing: ${COMMAND}"
	exec ${COMMAND}
else
	echo "Not executing: ${COMMAND}"
	echo "Executing: ${@}"
	exec $@
fi
