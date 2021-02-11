#!/bin/bash
# Adapted from https://github.com/shubham1172/setup
# This script backs up config files regularly

cd ${HOME}/setup

BACKUP=${HOME}/setup/backup

set -e

timestamp() {
  date +"%d-%m-%Y at %T"
}

# Use rsync to copy all files listed in backup file
grep -v '^$\|^\s*\#' $BACKUP | awk NF | while read -r line; do
	echo "$line" | awk '{ system("rsync " $1 " " $2) }'
done

# Export crontab
crontab -l > ~/setup/cron/crontab

# Export brew list
crontab -l > ~/setup/cron/crontab

# Get the stuff to Github
if [[ `git status --porcelain` ]]; then
	git pull origin main
	git add .
	git commit -m "automatic update: $(timestamp)"
	git push origin main
fi