#!/bin/bash
# Script to update local NRK SSH config at ~/.ssh/conf.d/nrk.conf

# Get NRK user ID from first program argument – exit early if missing
if echo $1 | grep -qE '^[0-9]{5,6}$'; then
    USERID=$1
else
    echo 'You need to provide a NRK user ID (5-6 digits, only digits) as an argument'
    exit 1
fi

file_age() {
    local filename=$1
    echo $(( $(date +%s) - $(date -r $filename +%s) ))
}

is_stale() {
    local filename=$1
    local max_minutes=$2
    [ $(file_age $filename) -gt $(( $max_minutes*60 )) ]
}

# Exit if nrk.conf has been updated last 10 minutes
if ! is_stale ~/.ssh/conf.d/nrk.conf 10; then
    echo '~/.ssh/conf.d/nrk.conf is already updated within last 10 minutes'
    exit 0
fi

# Check if we're connected to NRK felles
if curl -fsSo /dev/null https://portalenvpntest.felles.ds.nrk.no/ >/dev/null 2>&1; then
    # Try to get updated SSH config
    if curl -fsSo ~/.ssh/conf.d/nrk.conf.tmp http://sshcfg.linuxadmin.svc.int.nrk.cloud/?userid=$USERID >/dev/null 2>&1; then
        mv ~/.ssh/conf.d/nrk.conf.tmp ~/.ssh/conf.d/nrk.conf
        echo 'Successfully updated ~/.ssh/conf.d/nrk.conf'
    else
        echo 'Failed to update ~/.ssh/conf.d/nrk.conf'
        exit 1
    fi
else
    echo 'Not connected to NRK felles, so doing nothing'
fi

# Warning if nrk.conf hasn't been updated last week
if is_stale ~/.ssh/conf.d/nrk.conf 10080; then
    echo '~/.ssh/conf.d/nrk.conf is more than a week old!'
    exit 1
fi