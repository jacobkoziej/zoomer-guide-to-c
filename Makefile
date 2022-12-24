# SPDX-License-Identifier: CC-BY-NC-SA-4.0
#
# Copyright (C) 2022  Jacob Koziej <jacobkoziej@gmail.com>

SRC    := src
BUILD  ?= build
TEXSRC := $(shell find $(SRC) -type f -name '*.tex')

LUALATEX      := lualatex
LUALATEXFLAGS += \
	--halt-on-error \
	--interaction=nonstopmode \
	--output-directory='$(BUILD)'


export TEXINPUTS := $(SRC):$(TEXINPUTS)


.PHONY: all
all: $(BUILD)/zoomer-guide-to-c.pdf


.PHONY: clean
clean:
	@rm -rvf $(BUILD)


$(BUILD):
	@mkdir -p $(BUILD)
	@echo '*' > $(BUILD)/.gitignore


$(BUILD)/zoomer-guide-to-c.pdf: $(TEXSRC) | $(BUILD)


%.pdf:
	$(LUALATEX) $(LUALATEXFLAGS) $(notdir $(@:.pdf=.tex))
	$(LUALATEX) $(LUALATEXFLAGS) $(notdir $(@:.pdf=.tex))
