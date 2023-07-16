# SPDX-License-Identifier: GPL-3.0-or-later
#
# CommandOutput.py -- CommandOutput Builder
#
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

from os.path import basename

from SCons.Builder import Builder


def emitter(target, source, env):
    return ['${SOURCE.base}.output'], source


def generator(target, source, env, for_signature):
    command = basename(source[1].path) if len(source) >= 2 else basename(source[0].path)

    FORMAT_BOLD = '\\033[1m'
    FORMAT_NONE = '\\033[0m'

    commands = [ ]

    commands += [f'printf \'%b$ %b\' \'{FORMAT_BOLD}\' \'{FORMAT_NONE}\' > $TARGET.file']
    commands += [f'cat {command} >> $TARGET.file']
    commands += [f'script --flush --return --quiet --command \'$$(cat $SOURCE.file)\' >> $TARGET.file || true']

    return ['cd $SOURCE.dir && ' + command for command in commands]


def generate(env):
    if env.Detect('CommandOutput'):
        return

    builder = Builder(emitter=emitter, generator=generator)

    env['BUILDERS']['CommandOutput'] = builder


def exists(env):
    return env.Detect('CommandOutput')
