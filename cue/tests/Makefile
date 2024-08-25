# cue/tests/Makefile
SHELL := /bin/bash
PWD := $(CURDIR)
RPC_ROOT_DIR := $(shell dirname $(shell dirname $(PWD)))
MONO_ROOT_DIR := $(shell dirname $(shell dirname $(RPC_ROOT_DIR)))

include $(MONO_ROOT_DIR)/common.mk

YML_FILES := $(wildcard *.yml)

.PHONY: test
test:
	@fail=0; \
	for file in $(YML_FILES); do \
		name=$${file%.yml}; \
		d_argument="providers.$$name"; \
		echo "Running cue vet for $$file with -d $$d_argument"; \
		if ! cue vet ../providers ./$$file -d $$d_argument; then \
			echo "Validation failed for $$file"; \
			fail=1; \
		fi; \
	done; \
	exit $$fail
