#!/bin/bash
out=$(~/setup/backup.sh 2>&1 1> >(tee >(logger))) || terminal-notifier -title "Config backup" -message "$out"