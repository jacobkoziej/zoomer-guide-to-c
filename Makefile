# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2022  Jacob Koziej <jacobkoziej@gmail.com>

BIN    := bin
LIB    := lib
SRC    := src
BUILD  ?= build

LUALIB := $(shell find $(LIB) -type f -name '*.lua')

CSRC   := $(shell find $(SRC) -type f -name '*.c')
TEXSRC := $(shell find $(SRC) -type f -name '*.tex')

LIBZGTC_LUA := $(LIB)/zgtc/lua

LUALATEX      ?= lualatex
LUALATEXFLAGS += \
	--halt-on-error \
	--interaction=nonstopmode \
	--output-directory='$(BUILD)' \
	--shell-escape


export BUILD
export LUA_PATH  := $(LIBZGTC_LUA)/?;$(LIBZGTC_LUA)/?.lua;;
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


$(BUILD)/zoomer-guide-to-c.pdf: $(LUALIB) $(CSRC) $(TEXSRC) | $(BUILD)


%.pdf:
	$(LUALATEX) $(LUALATEXFLAGS) $(notdir $(@:.pdf=.tex))
	$(LUALATEX) $(LUALATEXFLAGS) $(notdir $(@:.pdf=.tex))
