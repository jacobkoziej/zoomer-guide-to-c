# SPDX-License-Identifier: GPL-3.0-or-later
#
# CommandOutput.py -- CommandOutput Builder
#
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

import SCons


def emitter(target, source, env):
    base = str(target[0])

    targets  = ['.stdout', '.stderr']
    targets += [target + '.tex' for target in targets]

    return [base + target for target in targets], source


def generator(target, source, env, for_signature):
    file = r'${SOURCE.filebase}'
    commands = [ ]

    def tex_gen(out):
        return f'\
            printf \'\\\\begin{{Verbatim}}\\n$ \' > {out}.tex &&\
            cat {file}.sh {out} >> {out}.tex &&\
            printf \'\\\\end{{Verbatim}}\\n\' >> {out}.tex'

    commands += [f'$SHELL < $SOURCE.file > {file}.stdout 2> {file}.stderr || true']
    commands += [tex_gen(f'{file}.stdout')]
    commands += [tex_gen(f'{file}.stderr')]

    return ['cd $SOURCE.dir && ' + command for command in commands]


def generate(env):
    if env.Detect('CommandOutput'):
        return

    builder = SCons.Builder.Builder(emitter=emitter, generator=generator)

    env['BUILDERS']['CommandOutput'] = builder


def exists(env):
    return env.Detect('CommandOutput')
