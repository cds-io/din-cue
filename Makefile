SHELL := /bin/bash

include ./common.mk

.PHONY: clean
## Cleanup all build assets
clean:
	@echo "Clean $(DIST_CUE_DIR)"
	@rm -rf $(DIST_CUE_DIR)
	@echo "Clean $(LOCAL_BUILD_DIR)"
	@rm -rf $(LOCAL_BUILD_DIR)

.PHONY: vet
## Vet all cue files
vet:
	@echo "Vet cue/chains"
	@$(MAKE) --no-print-directory -C cue/chains vet
	@echo "Vet cue/providers"
	@$(MAKE) --no-print-directory -C cue/providers vet

.PHONY: perf
## Measure CUE Performance
perf:
	@echo "Perf cue/chains"
	@$(MAKE) --no-print-directory -C cue/chains perf
	@echo "Perf cue/providers"
	@$(MAKE) --no-print-directory -C cue/providers perf

.PHONY: test
## Run Cue tests
test:
	@echo "test cue/tests"
	@$(MAKE) --no-print-directory -C cue/tests test


.PHONY: build
## Process Cue files and generate build assets
build: clean
	@mkdir -p $(LOCAL_BUILD_CHAINS_DIR)
	@mkdir -p $(LOCAL_BUILD_PROVIDERS_DIR)
	@mkdir -p $(LOCAL_BUILD_SOL_CHAINS_DIR)
	@mkdir -p $(LOCAL_BUILD_SOL_PROVIDERS_DIR)

	@echo "build cue/chains"
	@$(MAKE) --no-print-directory -C cue/chains build target_yml_dir="$(LOCAL_BUILD_CHAINS_DIR)" target_sol_dir="$(LOCAL_BUILD_SOL_PROVIDERS_DIR)"
	@echo "build cue/providers"
	@$(MAKE) --no-print-directory -C cue/providers build target_dir="$(LOCAL_BUILD_PROVIDERS_DIR)"

	@mkdir -p $(DIST_CONF_CHAINS_DIR)
	@mkdir -p $(DIST_CONF_PROVIDERS_DIR)
	@mkdir -p $(DIST_SOL_CHAINS_DIR)
	@mkdir -p $(DIST_SOL_PROVIDERS_DIR)
	
	@cp $(LOCAL_BUILD_CHAINS_DIR)/*.yml $(DIST_CONF_CHAINS_DIR)
	@cp $(LOCAL_BUILD_PROVIDERS_DIR)/*.yml $(DIST_CONF_PROVIDERS_DIR)
	@cp $(LOCAL_BUILD_SOL_CHAINS_DIR)/*.sol $(DIST_SOL_CHAINS_DIR)
	@cp $(LOCAL_BUILD_SOL_PROVIDERS_DIR)/*.sol $(DIST_SOL_PROVIDERS_DIR)

