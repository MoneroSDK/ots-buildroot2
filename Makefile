REPO := https://github.com/DiosDelRayo/monero.git
VERSION := 0.4.0
TAG := otslib-$(VERSION)
TARGET := monero-$(TAG)
TAR := $(TARGET).tar.gz
TEMP_DIR := monero-ots
BUILD_DIR := build
HASH_FILE := monero-ots.hash


$(TEMP_DIR):
	git clone --revision=refs/tag/$(TAG) --recursive $(REPO) $(TEMP_DIR)

$(TAR): $(TEMP_DIR)
	tar -c -z --exclude-vcs-ignores --exclude-vcs --exclude-caches --exclude-backups --transform='s/^$(TEMP_DIR)/$(TARGET)/' -f $(TAR) $(TEMP_DIR)

$(HASH_FILE): $(TAR)
	@echo -n 'sha256  ' > $(HASH_FILE)
	@sha256sum $($TAR) >> $(HASH_FILE)

$(BUILD_DIR): $(TEMP_DIR)
	mkdir -p build
	@cd build
	cmake ../$(TEMP_DIR)/ots/CMakeLists.txt
	make
	@cd ..

.PHONY: clean
clean:
	rm -rf $(TEMP_DIR) $(TAR)
