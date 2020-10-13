# Raspberry PI Chromium Kiosk
## Install
```
DISPLAY=:0.0 \
RPI_KIOSK_URL=http://localhost:1234 \
sudo dpkg -i rpi-chromium-kiosk-*.deb
```
## Uninstall
```
sudo dpkg -P rpi-chromium-kiosk
```