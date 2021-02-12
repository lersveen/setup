#!/bin/bash
# exec &> >(tee >(logger)
exec > >(logger -p user.info) 2> >(tee >(logger -p user.warn) | terminal-notifier -title "Config backup")
# exec 2> >(tee >(terminal-notifier -title "Config backup"))
~/setup/backup.sh