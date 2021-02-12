#!/bin/bash
exec 1> >(tee >(logger -t $(basename $0))) 2>&1
exec ~/setup/backup.sh 2>&1