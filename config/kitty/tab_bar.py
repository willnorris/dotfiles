from kitty.fast_data_types import get_options, Screen
from kitty.tab_bar import (
    DrawData,
    ExtraData,
    Formatter,
    TabBarData,
    as_rgb,
    draw_attributed_string,
    draw_title,
    get_boss,
)
from kitty.utils import color_as_int

opts = get_options()


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_tab_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    # if we are in a named session, show it before tabs
    if index == 1 and tab.session_name:
        fg, bg = screen.cursor.fg, screen.cursor.bg
        screen.cursor.bg = 0
        screen.cursor.fg = as_rgb(color_as_int(opts.color4))
        screen.draw(" " + tab.session_name + " ")
        screen.cursor.fg, screen.cursor.bg = fg, bg

    if draw_data.leading_spaces:
        screen.draw(" " * draw_data.leading_spaces)
    draw_title(draw_data, screen, tab, index, max_tab_length)
    trailing_spaces = min(max_tab_length - 1, draw_data.trailing_spaces)
    max_tab_length -= trailing_spaces
    extra = screen.cursor.x - before - max_tab_length
    if extra > 0:
        screen.cursor.x -= extra + 1
        screen.draw("…")
    if trailing_spaces:
        screen.draw(" " * trailing_spaces)
    end = screen.cursor.x
    screen.cursor.bold = screen.cursor.italic = False
    screen.cursor.fg = 0
    if not is_last:
        screen.cursor.bg = as_rgb(color_as_int(draw_data.inactive_bg))
    screen.cursor.bg = 0

    # show keyboard mode and layout on right side if set
    if is_last:
        trailers = []
        trailers.append((0, tab.layout_name))

        mode = get_boss().mappings.current_keyboard_mode_name
        if mode and not mode.startswith("__"):
            trailers.append((opts.color1, mode))

        offset = len(trailers)
        for t in trailers:
            offset += len(t[1])
        screen.cursor.x = screen.columns - offset

        for t in reversed(trailers):
            if t[0]:
                screen.cursor.fg = as_rgb(color_as_int(t[0]))
            else:
                screen.cursor.fg = 0
            screen.draw(" " + t[1])

    return end
