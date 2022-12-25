#!/bin/sh
# SPDX-License-Identifier: GPL-3.0-or-later
#
# version.sh -- report book version
# Copyright (C) 2022  Jacob Koziej <jacobkoziej@gmail.com>

VERSION=$(git describe --always --broken --dirty --tags 2> /dev/null)

echo "${VERSION:-v?.?.?}"
