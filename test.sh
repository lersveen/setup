#!/bin/bash
exec 1> >(tee >(logger))
exec ~/setup/backup.sh || terminal-notifier -title "Config backup" -message "$out"