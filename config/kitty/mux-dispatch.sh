#!/bin/sh
# ~/.config/kitty/mux-prefix-dispatch.sh
#
# This allows for a single key mapping to perform similar actions,
# like creating a new window or split, in both kitty and remote multiplexers.
#
# This is called from kitty key mappings using the form:
#
#     map ctrl+space>c remote_control_script mux-prefix-dispatch.sh c new_tab
#
# The first argument is the key to send to the multiplexer.
# The remaining arguments are the kitty action to run otherwise.
#
# If the terminal title includes the unicode code point U+2060 (word joiner),
# which is set by my terminal multiplexer config, the keypress is passed to the multiplexer.
# Otherwise, the specified kitty action is run.
#
# By default, only the given key is sent to the multiplexer.
# With --prefix, it is sent after the multiplexer prefix key (default: ctrl+space).

PREFIX=ctrl+space

use_prefix=
if [ "$1" = "--prefix" ]; then
    use_prefix=1
    shift
fi

remote_key="$1"; shift

if kitten @ ls --match state:self 2>/dev/null | grep -Fq '\u2060'; then
    if [ -n "$use_prefix" ]; then
        kitten @ send-key --match state:self "$PREFIX" "$remote_key"
    else
        kitten @ send-key --match state:self "$remote_key"
    fi
else
    kitten @ action --no-response --self "$@"
fi
