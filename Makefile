# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2022  Jacob Koziej <jacobkoziej@gmail.com>

BIN    := bin
SRC    := src
BUILD  ?= build
TEXSRC := $(shell find $(SRC) -type f -name '*.tex')

LUALATEX      := lualatex
LUALATEXFLAGS += \
	--halt-on-error \
	--interaction=nonstopmode \
	--output-directory='$(BUILD)'


export TEXINPUTS := $(SRC):$(TEXINPUTS)
export VERSION   := $(shell $(BIN)/version.sh)


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
