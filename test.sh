#!/bin/bash
exec 1> >(tee >(logger -t $(basename $0)) tee >(terminal-notifier -title "Config backup")) 2>&1
exec out=$(~/setup/backup.sh 2>&1) || terminal-notifier -title "Config backup" -message "$out"