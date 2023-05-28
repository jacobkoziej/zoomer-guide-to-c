# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

EnsureSConsVersion(4, 5)
EnsurePythonVersion(3, 11)


import os
import subprocess


license = 'GPL-3.0-or-later'
version = 'v0.0.0'

Export('license')
Export('version')


env = Environment()

if term := os.environ.get('TERM'):
    env['ENV']['TERM'] = term

env.Replace(PDFLATEX='lualatex')
env.AppendUnique(PDFLATEXFLAGS=[
    '--halt-on-error',
    '--interaction=nonstopmode',
    '--shell-escape',
])

git = env.WhereIs('git')

Export('env')
Export('git')


# use git version if possible
if git:
    version = subprocess.run(
        [git, 'describe', '--always', '--broken', '--dirty', '--tags'],
        capture_output=True,
        encoding='utf-8').stdout.strip()
    Export('version')


build = 'build'
src   = 'src'

VariantDir(build + '/' + src, src)
Clean(build, build)

SConscript([
    f'{build}/src/SConscript',
])
