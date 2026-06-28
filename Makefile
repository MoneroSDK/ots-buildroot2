REPO := https://github.com/MoneroSDK/monero-ots.git
VERSION := $(shell grep 'MONERO_OTS_VERSION '  monero-ots.mk | awk -F' = ' '{print $$2}')
TAG := otslib-$(VERSION)
TAR := $(TAG).tar.gz
TEMP_DIR := monero-ots
BUILD_DIR := build
HASH_FILE := monero-ots.hash
DL_URL := https://github.com/MoneroSDK/monero-ots/releases/download/$(TAG)/$(TAR)

default: clean-$(HASH_FILE) $(HASH_FILE)

all: clean-all $(BUILD_DIR) $(HASH_FILE)

$(TEMP_DIR):
	git clone --revision=refs/tags/$(TAG) --recursive $(REPO) $(TEMP_DIR)

$(TAR): $(TEMP_DIR)
	tar -c -z --exclude-vcs-ignores --exclude-vcs --exclude-caches --exclude-backups --transform='s/^$(TEMP_DIR)/$(TAG)/' -f $(TAR) $(TEMP_DIR)

$(HASH_FILE): $(TAR)
	@echo -n 'sha256  ' > $(HASH_FILE)
	@sha256sum $(TAR) >> $(HASH_FILE)
	@awk '{ print $$2 }' $(HASH_FILE)

$(BUILD_DIR): $(TEMP_DIR)
	mkdir -p build
	cd build && cmake ../$(TEMP_DIR)/ots/CMakeLists.txt && make && cd ..

.PHONY: clean
clean:
	rm -rf $(TEMP_DIR) $(BUILD_DIR)

.PHONY: clean-tar
clean-tar:
	rm -rf $(TAR) $(TAR)~

.PHONY: clean-hash
clean-hash:
	rm $(HASH_FILE)

.PHONY: clean-all
clean-all: clean clean-tar clean-hash

.PHONY: test
test: $(TAR) $(HASH_FILE)
	@mv $(TAR) $(TAR)~orig
	@wget -L -o $(TAG) "$(DL_URL)"
	@awk '{ print $$2"  $(TAR)"}' $(HASH_FILE) | sha256sum -c -
	@mv $(TAR)~orig $(TAR)
