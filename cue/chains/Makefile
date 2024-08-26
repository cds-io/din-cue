SHELL := /bin/bash
include ../../common.mk

LOCAL_BUILD_DIR := build
LOCAL_BUILD_CHAINS_DIR := $(LOCAL_BUILD_DIR)/conf/chains
LOCAL_BUILD_SOL_CHAINS_DIR := $(LOCAL_BUILD_DIR)/sol/chains

.PHONY: prepare-build-dirs
prepare-build-dirs:
	@mkdir -p $(LOCAL_BUILD_CHAINS_DIR)
	@mkdir -p $(LOCAL_BUILD_SOL_CHAINS_DIR)

.PHONY: clean
## Cleanup chains build assets
clean:
	$(ECHO_CMD) "Clean Chains"
	@rm -rf $(LOCAL_BUILD_DIR)
	@rm -rf $(DIST_CONF_CHAINS_DIR)
	@rm -rf $(DIST_SOL_CHAINS_DIR)

.PHONY: build
## Process the Cue files to produce build artifacts
build: prepare-build-dirs
	@printf "\t...chains\n"
	@cue cmd make
	@cp $(LOCAL_BUILD_CHAINS_DIR)/*.yml $(DIST_CONF_CHAINS_DIR)
	@cp $(LOCAL_BUILD_SOL_CHAINS_DIR)/*.sol $(DIST_SOL_CHAINS_DIR)


.PHONY: vet
## Validate Cue definitions
vet:
	@cue vet -i . 2> >($(ERROR_PARSER))

.PHONY: perf
## Measure CUE Performance
perf: prepare-build-dirs
	CUE_STATS_FILE=cue:chains-perf cue cmd make
	@cat chains-perf
