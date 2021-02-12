#!/bin/bash
out=$(exec ~/setup/backup.sh) 2>&1 || terminal-notifier -title "Config backup" -message "$out"
1> >(tee >(logger))