#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later
#
# lualatex.sh -- lualatex wrapper for meson
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

# lualatex.sh @INPUT0@ @OUTPUT0@ @PRIVATE_DIR@ ...

set -eou

INPUT="${1##*/}"
shift
OUTPUT="$1"
shift
export OUTDIR="$1"
shift

mkdir -p "$OUTDIR"
"$@" "$INPUT"
"$@" "$INPUT"
mv "$OUTDIR/${OUTPUT##*/}" "$OUTPUT"
