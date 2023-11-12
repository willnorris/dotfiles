// Preferences for hterm.js (ChromeOS Terminal).
//
// Run in the JavaScript console of the hterm browser window,
// opened with [Ctrl]+[Shift]+J.
//
// See also:
//  - https://chromium.googlesource.com/apps/libapps/+/HEAD/nassh/docs/FAQ.md
//  - https://chromium.googlesource.com/apps/libapps/+/HEAD/hterm/js/hterm_preference_manager.js

// Clear all existing settings. Note that settings are saved in
// the Chrome profile and are propagated to other devices.
//
//     term_.prefs_.storage.clear();

term_.setProfile("default");
term_.prefs_.resetAll();

// k
const prefs = {
  // colors
  "foreground-color": "#abb2bf",
  "background-color": "#1e1f24",
  "cursor-color": "#e06c7580",
  "color-palette-overrides": [
    "#2c323c", // black
    "#e06c75", // red
    "#98c379", // green
    "#e5c07b", // yellow
    "#61afef", // blue
    "#c678dd", // magenta
    "#56b6c2", // cyan
    "#5c6370", // white
    "#3e4452", // bright black
    "#e06c75", // bright red
    "#98c379", // bright green
    "#e5c07b", // bright yellow
    "#61afef", // bright blue
    "#c678dd", // bright magenta
    "#56b6c2", // bright cyan
    "#abb2bf", // bright white
  ],

  // typography
  "font-size": 14,
  "enable-bold": false,
  "font-family": '"CaskaydiaCove Nerd Font Mono", monospace',
  "user-css": "https://willnorris.com/fonts/caskaydia-cove.css",

  // window and behavior
  "scrollbar-visible": false,
  "desktop-notification-bell": true,
  "mouse-right-click-paste": false,
};

for (const [k, v] of Object.entries(prefs)) {
  term_.prefs_.set(k, v);
}
