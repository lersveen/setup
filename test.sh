#!/bin/bash
out=$(exec ~/setup/backup.sh) 2>&1 | $out 1> >(tee >(logger)) || terminal-notifier -title "Config backup" -message "$out"