#!/bin/sh

set -eu

timeout="${1:-60}"

while [ "$timeout" -gt 0 ]; do
    if ip -6 -o addr show up scope global | awk '($0 !~ / tentative / && $0 !~ / dadfailed / && $0 !~ / deprecated /) { found=1; exit } END { exit found ? 0 : 1 }'; then
        exit 0
    fi

    sleep 1
    timeout=$((timeout - 1))
done

echo "Timed out waiting for a usable global IPv6 address" >&2
exit 1
