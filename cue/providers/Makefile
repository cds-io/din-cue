# cue/providers/Makefile

SHELL := /bin/bash
include ../../common.mk


.PHONY: build
## Process the Cue files to produce build artifacts
build:
	@cue cmd make

.PHONY: vet
## Validate Cue definitions
vet:
	@cue vet -i . 2> >($(ERROR_PARSER))

.PHONY: perf
## Measure CUE Performance
perf:
	CUE_STATS_FILE=cue:providers-perf cue cmd make
	@cat providers-perf
