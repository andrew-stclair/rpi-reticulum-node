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
    if ip -6 -o addr show up scope global | awk '{ bad=($4 ~ /\/128$/); for (i=1; i<=NF; i++) { field=$i; sub(/:$/, "", field); if (field == "tentative" || field == "dadfailed" || field == "deprecated") { bad=1; continue } if (field == "valid_lft" || field == "preferred_lft") { key=field; if (++i > NF) { bad=1; break } if (key == "preferred_lft" && ($i == "0" || $i == "0sec")) bad=1 } } if (!bad) { found=1; exit } } END { exit found ? 0 : 1 }'; then
        exit 0
    fi

    [ "$timeout" -gt 0 ] || break
    sleep 1
    timeout=$((timeout - 1))
done

echo "Timed out waiting for a usable global IPv6 address" >&2
exit 1
