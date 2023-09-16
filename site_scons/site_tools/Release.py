# SPDX-License-Identifier: GPL-3.0-or-later
#
# Release.py -- Release Builder
#
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

from SCons.Defaults import Copy


def Release(env, name, source, **kwargs):
    version = kwargs.get('RELEASE_VERSION', env['RELEASE_VERSION'])

    release = f'$SOURCE.base-{version}$SOURCE.suffix'

    target = [ ]

    target += env.Command(release, source, action=Copy(f'{release}', '$SOURCE'), **kwargs)

    if kwargs.get('GPG_SIGN', False):
        release = target[-1]
        target += env.Command(f'{release}.asc', release, action=f'gpg --armor --detach-sig {release}')

    env.Alias(name, target)

    return target


def generate(env):
    if env.Detect('Release'):
        return

    env['RELEASE_VERSION'] = ''

    env.AddMethod(Release, 'Release')


def exists(env):
    return env.Detect('Release')
