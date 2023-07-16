# SPDX-License-Identifier: GPL-3.0-or-later
#
# pygments.c -- zgtc Pygments extensions
# Copyright (C) 2023  Jacob Koziej <jacobkoziej@gmail.com>

import pygments.styles.default
import pygments_ansi_color


class AnsiColorStyle(pygments.styles.default.DefaultStyle):
    """
    The ANSI color style (inspired by Emacs 22).
    """

    styles = dict(pygments.styles.default.DefaultStyle.styles)
    styles.update(pygments_ansi_color.color_tokens())
