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

git_repos() {
	for d in $(find ~ -path ~/Library -prune -o -path ~/.gnupg -prune -o -path ~/.Trash -prune -o -name '.git' -print 2> /dev/null)
	do 
		cd $d/..
		echo $(pwd | sed "s|${HOME}|~|") $(git config --get remote.origin.url)
	done
	cd $SETUPDIR
}

# Use rsync to copy all files listed in backup file
grep -v '^$\|^\s*\#' $BACKUP | awk NF | while read -r line; do
	echo "$line" | awk '{ system("rsync " $1 " " $2) }'
done

# Export crontab
crontab -l > $SETUPDIR/cron/crontab

# Export brew list of installed packages
brew list > $SETUPDIR/brew/brewlist.txt

# Export list of VS Code extensions
code --list-extensions > $SETUPDIR/vscode/vscode-extensions.txt

# Export list of git repos
git_repos > $SETUPDIR/git/repolist.txt

# Get the stuff to Github
if [[ $(git status --porcelain) ]]; then
	git pull -q origin main
	git add .
	git commit -q -m "automatic update: $(timestamp)"
	git push -q origin main
fi
