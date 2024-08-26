SHELL := /bin/bash

include ./common.mk

.PHONY: clean
## Cleanup all build assets
clean:
	@$(MAKE) --no-print-directory -C cue/chains clean
	@$(MAKE) --no-print-directory -C cue/providers clean
	$(ECHO_CMD) "Clean $(DIST_DIR)"
	@rm -rf $(DIST_DIR)


.PHONY: vet
## Vet all cue files
vet:
	$(ECHO_CMD) "Vet cue/chains"
	@$(MAKE) --no-print-directory -C cue/chains vet
	$(ECHO_CMD) "Vet cue/providers"
	@$(MAKE) --no-print-directory -C cue/providers vet

.PHONY: perf 
## Measure CUE Performance
perf: prepare-dirs
	$(ECHO_CMD) "Perf cue/chains"
	@$(MAKE) --no-print-directory -C cue/chains perf
	$(ECHO_CMD) "Perf cue/providers"
	@$(MAKE) --no-print-directory -C cue/providers perf

.PHONY: test
## Run Cue tests
test:
	$(ECHO_CMD) "test cue/tests"
	@$(MAKE) --no-print-directory -C cue/tests test


.PHONY: build
## Process Cue files and generate build assets
build: clean prepare-dirs
	$(ECHO_CMD) "build cue/chains"
	@$(MAKE) --no-print-directory -C cue/chains build target_yml_dir="$(LOCAL_BUILD_CHAINS_DIR)" target_sol_dir="$(LOCAL_BUILD_SOL_PROVIDERS_DIR)"
	$(ECHO_CMD) "build cue/providers"
	@$(MAKE) --no-print-directory -C cue/providers build target_dir="$(LOCAL_BUILD_PROVIDERS_DIR)"

