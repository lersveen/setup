#!/bin/bash
# Adapted from https://github.com/shubham1172/setup
# This script backs up config files regularly

source ~/.bashrc

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
rsync_files

# Export crontab
crontab -l > $SETUPDIR/cron/crontab

# Export brew list of installed packages
brew list > $SETUPDIR/brew/brewlist.txt

# Export list of VS Code extensions
code --list-extensions > $SETUPDIR/vscode/vscode-extensions.txt

# Search and export list of all git repositories cloned into home folder
git_repos() {
	for d in $(find ~ -path ~/Library -prune -o -path ~/.gnupg -prune -o -path ~/.Trash -prune -o -name '.git' -print 2> /dev/null)
	do 
		cd $d/..
		echo $(pwd | sed "s|${HOME}|~|") $(git config --get remote.origin.url)
	done
	cd $SETUPDIR
}
git_repos > $SETUPDIR/git/repolist.txt

# Check if there are any changes to push
if [[ $(git status --porcelain) ]]; then
	# Check if we can reach Github.com
	if ! nc -dzw1 github.com 443 &>/dev/null; then
		echo 'There are changes, but cannot connect to github.com, so stopping early'
		exit 0
	fi

	git pull -q origin main
	git add .
	git commit -q -m "automatic update: $(timestamp)"
	git push -q origin main
	echo 'Backup to Github succeeded'
else
	echo 'Nothing to backup'
fi
