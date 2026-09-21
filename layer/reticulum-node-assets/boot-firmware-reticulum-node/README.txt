Reticulum node first-boot configuration
=======================================

After flashing the image, mount the boot partition and place any of these files
in this directory before first boot:

- authorized_keys
  SSH public keys for the pi user.
- wpa_supplicant-wlan0.conf
  WiFi config copied to /etc/wpa_supplicant/wpa_supplicant-wlan0.conf
- reticulum.conf
  Reticulum config copied to /var/lib/reticulum/config
- reticulum-node.env
  Optional service environment overrides such as enabling IPv6 readiness wait

Example files are provided next to this README.
