# rpi-reticulum-node

Builds Raspberry Pi OS images with the Python `rns` package preinstalled and a
`systemd` service that starts a Reticulum node automatically.

This repository is designed to be used as a custom source root for
[`rpi-image-gen`](https://github.com/raspberrypi/rpi-image-gen).

## Included image targets

- `reticulum-node-zero.yaml` - Raspberry Pi Zero / Zero W compatible armhf image
- `reticulum-node-zero2w.yaml` - Raspberry Pi Zero 2 W arm64 image

## Features

- Reticulum installed into `/opt/reticulum-node/venv`
- `reticulum-node.service` started automatically on boot
- dedicated `reticulum` system user with no sudo access
- `pi` user for administration
- boot-partition based post-flash configuration for:
  - WiFi (`wpa_supplicant-wlan0.conf`)
  - SSH authorized keys for the `pi` user
  - Reticulum configuration (`reticulum.conf`)
- monthly GitHub Actions image builds with uploaded artifacts

## Quick start

1. Check out this repository.
2. Check out `rpi-image-gen`.
3. Run:

   ```bash
   /absolute/path/to/this/repo/scripts/build-image.sh zero2w /absolute/path/to/rpi-image-gen
   ```

See `/home/runner/work/rpi-reticulum-node/rpi-reticulum-node/docs/building-images.md`
for full build instructions and
`/home/runner/work/rpi-reticulum-node/rpi-reticulum-node/docs/flashing-and-configuration.md`
for flashing, WiFi, SSH, and Reticulum setup.

## Repository layout

- `/home/runner/work/rpi-reticulum-node/rpi-reticulum-node/config` - image build configs
- `/home/runner/work/rpi-reticulum-node/rpi-reticulum-node/device` - custom Raspberry Pi Zero device layer
- `/home/runner/work/rpi-reticulum-node/rpi-reticulum-node/layer` - custom layers and build assets
- `/home/runner/work/rpi-reticulum-node/rpi-reticulum-node/scripts` - local build helper
- `/home/runner/work/rpi-reticulum-node/rpi-reticulum-node/docs` - user and developer documentation
- `/home/runner/work/rpi-reticulum-node/rpi-reticulum-node/.github/workflows` - scheduled image builds
