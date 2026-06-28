REPO := https://github.com/DiosDelRayo/monero.git
VERSION := 0.4.1
TAG := otslib-$(VERSION)
TAR = $(TAG).tar.gz
SITE = https://github.com/MoneroSDK/monero-ots/archive/refs/tags
URL := $(SITE)/$(TAR)
BUILD_DIR := build-$(TAG)
HASH_FILE := monero-ots.hash
TEMP_DIR := monero-ots-$(TAG)

default: clean-$(HASH_FILE) $(HASH_FILE)

all: clean-all $(BUILD_DIR) $(HASH_FILE)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(TAR):
	wget -L "$(URL)"

$(HASH_FILE): $(TAR)
	@echo -n 'sha256  ' > $(HASH_FILE)
	@sha256sum $(TAR) >> $(HASH_FILE)
	@awk '{ print $$2 }' $(HASH_FILE)

$(TEMP_DIR): $(TAR)
	tar -xzf $(TAR)

.PHONY: build
build: $(TEMP_DIR) $(BUILD_DIR)
	cd build && cmake ../$(TEMP_DIR)/ots/CMakeLists.txt && make && cd ..

.PHONY: clean
clean:
	rm -rf $(TEMP_DIR) $(BUILD_DIR)

.PHONY: clean-$(TAR)
clean-$(TAR):
	rm -rf $(TAR)

.PHONY: clean-$(HASH_FILE)
clean-$(HASH_FILE):
	rm $(HASH_FILE)

.PHONY: clean-all
clean-all: clean clean-$(TAR) clean-$(HASH_FILE)
