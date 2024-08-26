MONO_ROOT_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))

# Define locations relative to the MONO_ROOT_DIR
ERROR_PARSER := ../../scripts/cue-error-parser.mjs

DIST_DIR := $(MONO_ROOT_DIR)dist
DIST_CUE_DIR := $(DIST_DIR)/cue
DIST_CONF_CHAINS_DIR := $(DIST_CUE_DIR)/config/chains
DIST_CONF_PROVIDERS_DIR := $(DIST_CUE_DIR)/config/providers
DIST_SOL_CHAINS_DIR := $(DIST_CUE_DIR)/solidity/chains
DIST_SOL_PROVIDERS_DIR := $(DIST_CUE_DIR)/solidity/providers


ifdef VERBOSE
ECHO_CMD = @echo
else
ECHO_CMD = @true
endif

.PHONY: prepare-chains-dir
prepare-chains-dir:
	$(ECHO_CMD) "dist: prepare chains directories"
	@mkdir -p $(DIST_CONF_CHAINS_DIR)
	@mkdir -p $(DIST_SOL_CHAINS_DIR)

.PHONY: prepare-providers-dir
prepare-providers-dir:
	$(ECHO_CMD) "dist: prepare providers directories"
	@mkdir -p $(DIST_CONF_PROVIDERS_DIR)
	@mkdir -p $(DIST_SOL_PROVIDERS_DIR)

.PHONY: prepare-dirs
prepare-dirs: prepare-chains-dir prepare-providers-dir


.PHONY: help
## Show this help message
help:
	$(ECHO_CMD) "Available targets:"
	@awk 'BEGIN {FS = ":.*"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} \
		/^\s*##/ {description=substr($$0, 4)} \
		/^[a-zA-Z_-]+:/ { \
			if (description) { \
				printf "  \033[36m%-15s\033[0m %s\n", $$1, description; \
				description = ""; \
			} \
		}' Makefile
