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

# Export brew list of installed packages
brew list > ~/setup/brew/brewlist.txt

# Export list of VS Code extensions
code --list-extensions > ~/setup/vscode/vscode-extensions.txt

# Get the stuff to Github
if [[ `git status --porcelain` ]]; then
	git pull -q origin main
	git add .
	git commit -q -m "automatic update: $(timestamp)"
	git push -q origin main
fi