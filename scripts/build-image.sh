#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-zero2w}"
RPI_IMAGE_GEN_DIR="${2:-${RPI_IMAGE_GEN_DIR:-}}"

case "$TARGET" in
  zero)
    CONFIG_PATH="$REPO_ROOT/config/reticulum-node-zero.yaml"
    ;;
  zero2w)
    CONFIG_PATH="$REPO_ROOT/config/reticulum-node-zero2w.yaml"
    ;;
  *)
    echo "Unknown target: $TARGET" >&2
    echo "Usage: $0 {zero|zero2w} /absolute/path/to/rpi-image-gen" >&2
    exit 1
    ;;
esac

if [[ -z "$RPI_IMAGE_GEN_DIR" ]]; then
  echo "Set RPI_IMAGE_GEN_DIR or pass /absolute/path/to/rpi-image-gen as the second argument." >&2
  exit 1
fi

if [[ ! -x "$RPI_IMAGE_GEN_DIR/rpi-image-gen" ]]; then
  echo "Could not find executable rpi-image-gen at: $RPI_IMAGE_GEN_DIR/rpi-image-gen" >&2
  exit 1
fi

exec "$RPI_IMAGE_GEN_DIR/rpi-image-gen" build -S "$REPO_ROOT" -c "$CONFIG_PATH"
