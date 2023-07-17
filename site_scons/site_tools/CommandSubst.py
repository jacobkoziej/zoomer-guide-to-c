# SPDX-License-Identifier: GPL-3.0-or-later
#
# CommandSubst.py -- CommandSubst Builder
#
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

def CommandSubst(env, *args, **kwargs):
    if 'SUBST_DICT' not in kwargs.keys():
        kwargs['SUBST_DICT'] = env['COMMANDSUBST_DICT']

    return env.Substfile(*args, **kwargs)


def generate(env):
    if env.Detect('CommandSubst'):
        return

    env['COMMANDSUBST_DICT'] = { }

    env.AddMethod(CommandSubst, 'CommandSubst')


def exists(env):
    return env.Detect('CommandSubst')
