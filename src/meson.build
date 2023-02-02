# SPDX-License-Identifier: GPL-3.0-or-later
#
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

build_dir = meson.current_build_dir()
src_dir   = meson.current_source_dir()

zgtc_env.prepend('TEXINPUTS', src_dir)
zgtc_env.prepend('TEXINPUTS', ':' + build_dir)

unset_variable('build_dir')
unset_variable('src_dir')


vcs_tag_cmd = git.found() ? [
        git,
        'describe',
        '--always',
        '--broken',
        '--dirty',
        '--tags'
] : ''

vcs_tag_tex = vcs_tag(
        command : vcs_tag_cmd,
        input   : 'vcs-tag.tex',
        output  : 'vcs-tag.tex',
)


zgtc_sources += files(
        '_start.tex',
        'copyright.tex',
        'hello-world.tex',
        'preamble.tex',
        'preface.tex',
        'title.tex',
)

zgtc_targets += vcs_tag_tex


subdir('preface.d')


zgtc = custom_target(
        output : 'zoomer-guide-to-c.pdf',
        input  : [
                'zoomer-guide-to-c.tex',
                zgtc_sources,
                zgtc_targets,
        ],
        command : [
                lualatex_sh,
                '@INPUT0@',
                '@OUTPUT0@',
                '@PRIVATE_DIR@',
                lualatex,
                '--halt-on-error',
                '--interaction=nonstopmode',
                '--output-directory=@PRIVATE_DIR@',
                '--shell-escape',
        ],
        env              : zgtc_env,
        build_by_default : true,
)
