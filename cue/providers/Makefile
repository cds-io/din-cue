SHELL := /bin/bash
include ../../common.mk

LOCAL_BUILD_DIR := build
LOCAL_BUILD_PROVIDERS_DIR := $(LOCAL_BUILD_DIR)/conf/providers
LOCAL_BUILD_SOL_PROVIDERS_DIR := $(LOCAL_BUILD_DIR)/sol/providers

.PHONY: prepare-build-dirs
prepare-build-dirs:
	$(ECHO_CMD) "Providers: prepare build directories"
	@mkdir -p $(LOCAL_BUILD_PROVIDERS_DIR)
	@mkdir -p $(LOCAL_BUILD_SOL_PROVIDERS_DIR)

.PHONY: clean
## Cleanup chains build assets
clean:
	$(ECHO_CMD) "Clean Providers"
	@rm -rf $(LOCAL_BUILD_DIR)
	@rm -rf $(DIST_CONF_PROVIDERS_DIR)
	@rm -rf $(DIST_SOL_PROVIDERS_DIR)

.PHONY: build 
## Process the Cue files to produce build artifacts
build: prepare-build-dirs
	@printf "\t...providers\n"
	@cue cmd make
	@cp $(LOCAL_BUILD_PROVIDERS_DIR)/*.yml $(DIST_CONF_PROVIDERS_DIR)
	@cp $(LOCAL_BUILD_SOL_PROVIDERS_DIR)/*.sol $(DIST_SOL_PROVIDERS_DIR)

.PHONY: vet
## Validate Cue definitions
vet:
	@cue vet -i . 2> >($(ERROR_PARSER))

.PHONY: perf
## Measure CUE Performance
perf: prepare-build-dirs
	CUE_STATS_FILE=cue:providers-perf cue cmd make
	@cat providers-perf
