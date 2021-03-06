# Setup
Personal backup tool for local configuration, with documentation for some applications. 

- Adapted from [github.com/shubham1172/setup](https://github.com/shubham1172/setup)
- Be aware that my version has parts that are MacOS specific
- Copy as you please, but make sure you adapt to your own setup

## Prerequisites
If you're not me, make your own blank Github repository called `setup` first.

Initiate the repo locally:
```sh
$ mkdir ~/setup && cd ~/setup
$ git init
$ git remote add origin git@github.com:<username>/setup.git
```
Also, create folders inside the setup directory where you want to backup stuff.

## Setting up
You need to create two files. The first file, called `backup`, holds a list of files that you want to backup and it looks like this:
```
# bash
~/.bashrc ~/setup/bash/.bashrc
~/.bash_profile ~/setup/bash/.bash_profile

# vscode
~/Library/ApplicationSupport/Code/User/settings.json ~/setup/vscode
```
Each line should have the format: `<source [original file location]> <destination [in the local git repository]>`

Next, you need a shell script – [backup.sh](backup.sh). It does several things:
- Reads the `backup` file and copies listed files one by one with rsync
- Copies user crontab to `~/setup/cron/crontab`
- Exports list of installed Homebrew packages to `~/setup/brew/brewlist.txt`
- Exports list of VS Code extensions to `~/setup/vscode/vscode-extensions.txt`
- Searches `~` for git repos and exports a list to `~/setup/git/repolist.txt`
- If any files in `~/setup` has changed, it is committed and pushed to the git repository.

## Backup your configs

### As cronjob
1. Open user crontab for editing:
    ```sh
    $ crontab -e
    ```

2. Add this line:
    ```
    00 * * * *  /bin/bash -c 'out=$(~/setup/backup.sh 2>&1 &> >(tee >(logger))) || terminal-notifier -title "Config backup" -message "$out"' > /dev/null
    ```

### Logging and error handling
- Both `stdout` and `stderr` will be logged to the system log with `logger`
- On error a notification is sent with [terminal-notifier](https://github.com/julienXX/terminal-notifier) (needs to be installed)
- Logs can be read using:
    ```sh
    $ log show --style compact --info --debug --predicate 'process == "logger"' --last 24h
    ```

### Linux (not tested)
Should be same as Mac cronjob example, but add this line instead – swapping `terminal-notifier` for `notify-send`:
00 * * * *  /bin/bash -c 'out=$(~/setup/backup.sh 2>&1 &> >(tee >(logger))) || notify-send "Config backup" "$out"' > /dev/null

## Restore
Coming soon!
