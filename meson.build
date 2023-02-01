# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

project(
        'zoomer-guide-to-c',
        'c',
        version : 'v0.0.0',
        license : 'GPL-3.0-or-later',
        default_options : [
                'c_std=c17',
                'warning_level=3',
        ],
        meson_version : '>=1.0.0',
)


# programs
git         = find_program('git', required : false)
lualatex    = find_program('lualatex')
lualatex_sh = find_program('bin/lualatex.sh')


subdir('src')
