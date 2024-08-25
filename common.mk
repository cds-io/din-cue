MONO_ROOT_DIR := $(CURDIR)

# Define locations relative to the MONO_ROOT_DIR
ERROR_PARSER := ../../scripts/cue-error-parser.mjs

DIST_DIR := $(MONO_ROOT_DIR)/dist
DIST_CUE_DIR := $(DIST_DIR)/cue
DIST_CONF_CHAINS_DIR := $(DIST_CUE_DIR)/config/chains
DIST_CONF_PROVIDERS_DIR := $(DIST_CUE_DIR)/config/providers
DIST_SOL_CHAINS_DIR := $(DIST_CUE_DIR)/solidity/chains
DIST_SOL_PROVIDERS_DIR := $(DIST_CUE_DIR)/solidity/providers

LOCAL_BUILD_DIR := build
LOCAL_BUILD_CHAINS_DIR := $(LOCAL_BUILD_DIR)/conf/chains
LOCAL_BUILD_PROVIDERS_DIR := $(LOCAL_BUILD_DIR)/conf/providers
LOCAL_BUILD_SOL_DIR := $(LOCAL_BUILD_DIR)/sol
LOCAL_BUILD_SOL_CHAINS_DIR := $(LOCAL_BUILD_SOL_DIR)/chains
LOCAL_BUILD_SOL_PROVIDERS_DIR := $(LOCAL_BUILD_SOL_DIR)/providers


.PHONY: help
## Show this help message
help:
	@echo "Available targets:"
	@awk 'BEGIN {FS = ":.*"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} \
		/^\s*##/ {description=substr($$0, 4)} \
		/^[a-zA-Z_-]+:/ { \
			if (description) { \
				printf "  \033[36m%-15s\033[0m %s\n", $$1, description; \
				description = ""; \
			} \
		}' Makefile
