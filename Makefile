# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2022  Jacob Koziej <jacobkoziej@gmail.com>

BIN    := bin
SRC    := src
BUILD  ?= build

CSRC   := $(shell find $(SRC) -type f -name '*.c')
LUASRC := $(shell find $(SRC) -type f -name '*.lua')
TEXSRC := $(shell find $(SRC) -type f -name '*.tex')

LUALATEX      ?= lualatex
LUALATEXFLAGS += \
	--halt-on-error \
	--interaction=nonstopmode \
	--output-directory='$(BUILD)' \
	--shell-escape


export BUILD
export LUA_PATH  := $(SRC)/?;$(SRC)/?.lua;;
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


$(BUILD)/zoomer-guide-to-c.pdf: $(CSRC) $(LUASRC) $(TEXSRC) | $(BUILD)


%.pdf:
	$(LUALATEX) $(LUALATEXFLAGS) $(notdir $(@:.pdf=.tex))
	$(LUALATEX) $(LUALATEXFLAGS) $(notdir $(@:.pdf=.tex))
