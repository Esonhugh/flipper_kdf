FIRMWARE_PATH = ./flipperzero-firmware

FIRMWARE_DEFAULT_GIT_REPO ?= "https://github.com/DarkFlippers/unleashed-firmware.git" 

build: download-default
build: firmware-init
build: copy-file
build: build-fal

# Download Firmwares
download-default: 
	echo "Downloading firmware from $(FIRMWARE_DEFAULT_GIT_REPO)"
	git clone $(FIRMWARE_DEFAULT_GIT_REPO) $(FIRMWARE_PATH)

download-unleash:
	git clone https://github.com/DarkFlippers/unleashed-firmware.git $(FIRMWARE_PATH)

download-official:
	git clone https://github.com/flipperdevices/flipperzero-firmware.git $(FIRMWARE_PATH)

download-xtreme:
	git clone https://github.com/Flipper-XFW/Xtreme-Firmware.git $(FIRMWARE_PATH)

# init firmware to latest tag
firmware-init:
	@cd $(FIRMWARE_PATH); git checkout `git ls-remote --tags --sort=committerdate 2>/dev/null | grep -o 'tags/.*' | grep -v rc | tail -n1`; echo "`git ls-remote --tags --sort=committerdate 2>/dev/null | grep -o 'tags/.*' | grep -v rc | tail -n1`"

firmware-info:
	@cd $(FIRMWARE_PATH); git describe --tags

firmware-clean:
	rm -rf $(FIRMWARE_PATH)
# copy files to firmware folder
copy-code:
	cp ./plugins/supported_cards/credit.c $(FIRMWARE_PATH)/applications/main/nfc/plugins/supported_cards/credit.c

copy-file: copy-code
	cat ./application.fam >> $(FIRMWARE_PATH)/applications/main/nfc/application.fam

# build for artifacts
build-dir:
	mkdir -p ./build

build-fal: build-dir
	@cd $(FIRMWARE_PATH); ./fbt fap_dist
	cp $(FIRMWARE_PATH)/dist/f7-D/apps_data/nfc/plugins/credit_parser.fal ./build/credit_parser.fal

# rebuild firmware if code modified
rebuild: copy-code
rebuild: build-fal

# clean up everything
clean:
	rm -rf ./build
	rm -rf $(FIRMWARE_PATH)/dist
	rm -rf $(FIRMWARE_PATH)/build
