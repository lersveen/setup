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
if [[ $(rsync_files) ]]; then
	echo "Copied files listed in $BACKUP"
fi

# Export crontab
if [[ $(crontab -l > $SETUPDIR/cron/crontab) ]]; then
	echo "Exported crontab"
fi

# Export brew list of installed packages
if [[ $(brew list > $SETUPDIR/brew/brewlist.txt) ]]; then
	echo "Exported brew list"
fi

# Export list of VS Code extensions
if [[ $(code --list-extensions > $SETUPDIR/vscode/vscode-extensions.txt) ]]; then
	echo "Exported vscode-extensions list"
fi

# Search and list all git repositories cloned into home folder
git_repos() {
	for d in $(find ~ -path ~/Library -prune -o -path ~/.gnupg -prune -o -path ~/.Trash -prune -o -name '.git' -print 2> /dev/null)
	do 
		cd $d/..
		echo $(pwd | sed "s|${HOME}|~|") $(git config --get remote.origin.url)
	done
	cd $SETUPDIR
}

# Export list of git repos
if [[ $(git_repos > $SETUPDIR/git/repolist.txt) ]]; then
	echo "Exported vscode-extensions list"
fi

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
