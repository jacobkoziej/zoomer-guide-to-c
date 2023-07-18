# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

EnsureSConsVersion(4, 5)
EnsurePythonVersion(3, 11)


import os
import subprocess


license = 'GPL-3.0-or-later'
version = 'v0.1.1'

Export('license')
Export('version')


build = 'build'
lib   = 'lib/zgtc'
src   = 'src'


env = Environment(tools=[
    'default',
    'CommandOutput',
    'CommandSubst',
    'Release',
])

if path := os.environ.get('PATH'):
    env['ENV']['PATH'] = path

if term := os.environ.get('TERM'):
    env['ENV']['TERM'] = term

env.Replace(CC='clang')
env['COMMANDSUBST_DICT']['@CC@'] = '$CC'

env.Replace(PDFLATEX='lualatex')
env.AppendUnique(PDFLATEXFLAGS=[
    '--halt-on-error',
    '--shell-escape',
])

git    = env.WhereIs('git')
python = env.WhereIs('python')

Export('env')
Export('git')


# use git version if possible
if git:
    version = subprocess.run(
        [git, 'describe', '--always', '--broken', '--dirty', '--tags'],
        capture_output=True,
        encoding='utf-8').stdout.strip()
    Export('version')

env['RELEASE_VERSION'] = version


env['zgtc'] = [ ]


# virtual environment
venv_path = env.Dir(f'{build}/venv')
venv = env.Command(venv_path, '', f'{python} -m venv {venv_path}')

env['ENV']['VIRTUAL_ENV'] = venv_path.abspath
env.PrependENVPath('PATH', f'{venv_path.abspath}/bin')

env['zgtc'] += venv

# change python's path to be within the virtual environment
python = f'{venv_path.abspath}/bin/python'

Export('python')
Export('venv')


VariantDir(f'{build}/{lib}', lib)
VariantDir(f'{build}/{src}', src)

SConscript([
    f'{build}/{lib}/SConscript',
    f'{build}/{src}/SConscript',
])


Import('zgtc')
env.Default(zgtc)

env.Release('release', zgtc, GPG_SIGN=True)
