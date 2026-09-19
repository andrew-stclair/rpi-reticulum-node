# Building images

## Prerequisites

- a Debian-based Linux host supported by `rpi-image-gen`
- a checkout of this repository
- a checkout of `https://github.com/raspberrypi/rpi-image-gen`

## Install `rpi-image-gen` dependencies

```bash
cd /absolute/path/to/rpi-image-gen
sudo ./install_deps.sh
```

## Build an image

### Raspberry Pi Zero / Zero W

```bash
./scripts/build-image.sh zero /absolute/path/to/rpi-image-gen
```

### Raspberry Pi Zero 2 W

```bash
./scripts/build-image.sh zero2w /absolute/path/to/rpi-image-gen
```

The resulting images are written into the `work/` directory inside the
`rpi-image-gen` checkout.
