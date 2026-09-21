#!/bin/sh

set -eu

timeout="${1:-60}"

case "$timeout" in
    '' | *[!0-9]*)
        echo "IPv6 wait timeout must be a non-negative integer" >&2
        exit 1
        ;;
esac

while :; do
    if ip -6 -o addr show up scope global | awk '{ bad=0; for (i=1; i<=NF; i++) if ($i == "tentative" || $i == "dadfailed" || $i == "deprecated" || ($i == "preferred_lft" && i < NF && $(i+1) == "0sec")) bad=1; if (!bad) { found=1; exit } } END { exit found ? 0 : 1 }'; then
        exit 0
    fi

    [ "$timeout" -gt 0 ] || break
    sleep 1
    timeout=$((timeout - 1))
done

echo "Timed out waiting for a usable global IPv6 address" >&2
exit 1
