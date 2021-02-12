#!/bin/bash
exec 1> >(tee >(logger -t $(basename $0)) tee >(terminal-notifier -title "Config backup")) 2>&1 || echo 'errors???'
exec ~/setup/backup.sh 2>&1