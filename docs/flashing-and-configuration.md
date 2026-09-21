# Flashing and configuration

## 1. Build or download an image

Use one of the generated `*.img.zst` artifacts from GitHub Actions, or build an
image locally as described in
[`docs/building-images.md`](building-images.md).

## 2. Flash the image

Flash the image to a microSD card with Raspberry Pi Imager or `dd`.

If the image is compressed:

```bash
zstd -d reticulum-node-zero2w-bookworm.img.zst
```

Example flashing command:

```bash
sudo dd if=reticulum-node-zero2w-bookworm.img of=/dev/sdX bs=4M conv=fsync status=progress
```

## 3. Configure the boot partition before first boot

After flashing, remove and reinsert the microSD card. Open the boot partition
and go to:

`reticulum-node/`

That directory contains example files you can copy and rename.

### WiFi

Copy `wpa_supplicant-wlan0.conf.example` to `wpa_supplicant-wlan0.conf` and set
your country, SSID, and PSK.

### SSH for the `pi` user

Copy `authorized_keys.example` to `authorized_keys` and add your SSH public
key(s).

SSH is configured for public-key authentication only. Password login is
disabled.

### Reticulum node

Copy `reticulum.conf.example` to `reticulum.conf` and add your interface
configuration.

If you want `reticulum-node.service` to wait for a usable global IPv6 address
before startup, copy `reticulum-node.env.example` to `reticulum-node.env` and
set:

```sh
RETICULUM_WAIT_FOR_IPV6=1
```

Accepted enable values are `1`, `y`, `yes`, `t`, `true`, and `on`
(case-insensitive, surrounding whitespace ignored).

You can also override the timeout in seconds with
`RETICULUM_WAIT_FOR_IPV6_TIMEOUT`.

The active Reticulum runtime directory on the device is:

`/var/lib/reticulum`

The Reticulum service runs as the dedicated `reticulum` user.

## 4. First boot

Insert the card into the Raspberry Pi and boot it. On startup, the image will:

- apply any files you placed in `boot/firmware/reticulum-node`
- configure WiFi if `wpa_supplicant-wlan0.conf` is present
- install `pi` user SSH keys if `authorized_keys` is present
- update the Reticulum config if `reticulum.conf` is present
- start `reticulum-node.service`

## 5. Post-boot administration

- `pi` is the administrative user
- `reticulum` is the dedicated service user and does not have root privileges

Useful commands:

```bash
sudo systemctl status reticulum-node.service
sudo journalctl -u reticulum-node.service -f
sudo -u reticulum /opt/reticulum-node/venv/bin/rnsd --exampleconfig
```

## Notes for Raspberry Pi Zero

The Raspberry Pi Zero image is intended for Raspberry Pi Zero class armhf
hardware. For WiFi, use a Raspberry Pi Zero W or a supported external adapter.
