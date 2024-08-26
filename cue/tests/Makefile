# cue/tests/Makefile
SHELL := /bin/bash
include ../../common.mk

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
