# xdg-desktop-portal-wlr

## headless output

GitHub issue [emersion/xdg-desktop-portal-wlr#107] is a feature request to screenshare individual windows.
That feature has not been implemented yet, but [ngotchac] shared scripts to work around the limitation.
It creates a new headless output off-screen that can be used for screensharing,
and then uses [wl-mirror] to mirror that output to a window shown on a real output so you can see what is being shared.
It works surprisingly well, and is in some ways even better than sharing an individual window,
since it is a regular output that you can move windows to and from.

The scripts themselves don't have any kind of license, but xdg-desktop-portal-wlr is MIT licensed,
so maybe these can be thought of as a contribution to that project?
Regardless, I've pulled them out into a vendor directory to make sure attribution is clear.

[emersion/xdg-desktop-portal-wlr#107]: https://github.com/emersion/xdg-desktop-portal-wlr/issues/107
[ngotchac]: https://github.com/ngotchac
[wl-mirror]: https://github.com/Ferdi265/wl-mirror
