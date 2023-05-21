# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

EnsureSConsVersion(4, 5)
EnsurePythonVersion(3, 11)


import os


license = 'GPL-3.0-or-later'
version = 'v0.0.0'

Export('license')
Export('version')


env = Environment()

if term := os.environ.get('TERM'):
    env['ENV']['TERM'] = term

Export('env')
