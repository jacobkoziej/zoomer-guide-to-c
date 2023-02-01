# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

src_dir = meson.current_source_dir()

zgtc_env.prepend('LUA_PATH', src_dir + '/lua/?',     separator : ';')
zgtc_env.prepend('LUA_PATH', src_dir + '/lua/?.lua', separator : ';')

unset_variable('src_dir')
