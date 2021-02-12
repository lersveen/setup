#!/bin/bash
out=$(~/setup/backup.sh 2> >(tee >(logger)) 2>&1) || terminal-notifier -title "Config backup" -message "$out"