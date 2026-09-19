#!/bin/sh
set -eu

BOOT_DIR=/boot/firmware/reticulum-node

[ -d "$BOOT_DIR" ] || exit 0

if [ -s "$BOOT_DIR/authorized_keys" ]; then
    install -d -m 0700 -o pi -g pi /home/pi/.ssh
    install -m 0600 -o pi -g pi "$BOOT_DIR/authorized_keys" /home/pi/.ssh/authorized_keys
fi

if [ -s "$BOOT_DIR/wpa_supplicant-wlan0.conf" ]; then
    install -d -m 0755 /etc/wpa_supplicant
    install -m 0600 "$BOOT_DIR/wpa_supplicant-wlan0.conf" /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
    rm -f "$BOOT_DIR/wpa_supplicant-wlan0.conf"
    systemctl enable wpa_supplicant@wlan0.service >/dev/null 2>&1 || true
    systemctl restart wpa_supplicant@wlan0.service >/dev/null 2>&1 || systemctl start wpa_supplicant@wlan0.service >/dev/null 2>&1 || true
fi

if [ -s "$BOOT_DIR/reticulum.conf" ]; then
    install -m 0640 -o reticulum -g reticulum "$BOOT_DIR/reticulum.conf" /var/lib/reticulum/config
    rm -f "$BOOT_DIR/reticulum.conf"
fi
