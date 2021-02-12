#!/bin/bash
# Adapted from https://github.com/shubham1172/setup
# This script backs up config files regularly

SETUPDIR=~/setup
BACKUP=$SETUPDIR/backup

cd $SETUPDIR

set -e

timestamp() {
  date +"%d-%m-%Y at %T"
}

# Use rsync to copy all files listed in backup file
rsync_files() {
	grep -v '^$\|^\s*\#' $BACKUP | awk NF | while read -r line; do
		echo "$line" | awk '{ system("rsync " $1 " " $2) }'
	done
}
rsync_files && \
echo "Copied files listed in $BACKUP"

# Export crontab
crontab -l > $SETUPDIR/cron/crontab && \
echo "Exported crontab"

# Export brew list of installed packages
brew list > $SETUPDIR/brew/brewlist.txt && \
echo "Exported brew list"

# Export list of VS Code extensions
code --list-extensions > $SETUPDIR/vscode/vscode-extensions.txt && \
echo "Exported vscode-extensions list"

# Search and export list of all git repositories cloned into home folder
git_repos() {
	for d in $(find ~ -path ~/Library -prune -o -path ~/.gnupg -prune -o -path ~/.Trash -prune -o -name '.git' -print 2> /dev/null)
	do 
		cd $d/..
		echo $(pwd | sed "s|${HOME}|~|") $(git config --get remote.origin.url)
	done
	cd $SETUPDIR
}
git_repos > $SETUPDIR/git/repolist.txt && \
echo "Exported vscode-extensions list"

# Get the stuff to Github
if [[ $(git status --porcelain) ]]; then
	git pull -q origin main
	git add .
	git commit -q -m "automatic update: $(timestamp)"
	git push -q origin main
	echo 'Backup succeeded'
else
	echo 'Nothing to backup'
fi
