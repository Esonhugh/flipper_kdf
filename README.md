# FlipperZero KDF

# Aim 

This project aims to provide a plugin for flipperzero to parse the specific type credit card data from the NFC card.

It's completely research purpose project.

# Usage

1. download the release matches your flipperzero firmware version
2. connect to your flipperzero with qFlipper on PC
3. get the downloaded `credit_parser.fal` to your flipperzero: `SDCard/apps_data/nfc/plugins/credit_parser.fal`
4. read and Scan your card as normal with `NFC` app \[NFC -> Read\]

# How to build

## manually

1. git clone the firmware
2. copy `credit_parser.c` to `flipperzero-firmware/applications/main/nfc/plugins/supported_cards` folder
3. append `flipperzero-firmware/applications/main/nfc/application.fam` with `application.fam`
4. build with `./fbt fap_dist`
5. found at `flipperzero-firmware/dist/f7-D/apps_data/nfc/plugins/credit_parser.fal`

## with makefile

1. make download-unleash or make download-XXXXX 
2. make firmware-init
3. make copy-file
4. make build
5. if you changed codes, and you want rebuild it
6. make rebuild
7. look at your ./build folder for plugin

# happy hacking