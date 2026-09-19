# AI development context

## Project purpose

This repository is not a standalone image builder. It is a custom source root
for `rpi-image-gen` that adds Reticulum-specific layers, configs, and CI.

## Important files

- `config/reticulum-node-zero.yaml` - armhf Raspberry Pi Zero build
- `config/reticulum-node-zero2w.yaml` - arm64 Raspberry Pi Zero 2 W build
- `device/zero/device.yaml` - custom Pi Zero device layer
- `layer/rpi-linux-rpi.yaml` - custom kernel layer for Pi Zero class devices
- `layer/reticulum-node-common.yaml` - shared Reticulum packages, services, and first-boot hooks
- `layer/reticulum-node-assets/` - installed systemd units, boot-partition templates, and default Reticulum config
- `scripts/build-image.sh` - local wrapper around `rpi-image-gen build`
- `.github/workflows/build-images.yml` - scheduled matrix build

## Runtime model

- `pi` is the admin user
- `reticulum` is the service user
- Reticulum state and config live in `/var/lib/reticulum`
- the service command is `/opt/reticulum-node/venv/bin/rnsd --config /var/lib/reticulum`
- boot-partition configuration is applied by `reticulum-boot-config.service`

## Extension points

- add more image targets by creating new files in `config/`
- change the installed Reticulum package with `reticulum.pip_spec`
- add more first-boot inputs by extending `apply-boot-config.sh`
