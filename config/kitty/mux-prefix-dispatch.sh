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
# If the terminal title includes the unicode code point U+2060 (word joiner),
# which is set by my terminal multiplexer config, the keypress is passed to the multiplexer.
# Otherwise, the specified kitty action is run.

remote_key="$1"; shift

if kitten @ ls --match state:self 2>/dev/null | grep -Fq '\u2060'; then
    kitten @ send-key --match state:self ctrl+space "$remote_key"
else
    kitten @ action --no-response --match state:self "$@"
fi
