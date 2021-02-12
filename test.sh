#!/bin/bash
exec 1> >(tee >(logger))
out=$(~/setup/backup.sh) 2>&1 || terminal-notifier -title "Config backup" -message "$out"