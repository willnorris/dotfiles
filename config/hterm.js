// Run in the JavaScript console of the hterm browser window

// Modified from https://gist.github.com/russelldavies/5745528

// Clear all existing settings - you probably don't want to do this.
// Preferences are now stored in "chrome.storage.sync" instead of
// "window.localStorage" so if you clear your preferences the changes
// will be propagated to other devices.
//term_.prefs_.storage.clear();

var colors = {
  'base03':  '#002b36',
  'base02':  '#073642',
  'base01':  '#586e75',
  'base00':  '#657b83',
  'base0':   '#839496',
  'base1':   '#93a1a1',
  'base2':   '#eee8d5',
  'base3':   '#fdf6e3',
  'yellow':  '#b58900',
  'orange':  '#cb4b16',
  'red':     '#dc322f',
  'magenta': '#d33682',
  'violet':  '#6c71c4',
  'blue':    '#268bd2',
  'cyan':    '#2aa198',
  'green':   '#859900'
};

var htermProfiles = {
    'solarized-dark': {
        'background-color': colors.base03,
        'foreground-color': colors.base0,
    },
    'solarized-light': {
        'background-color': colors.base3,
        'foreground-color': colors.base00,
    },
};

// set default profile
htermProfiles['default'] = htermProfiles['solarized-dark'];

var currentProfile = term_.profileId_;

for (name in htermProfiles) {
    prefs = htermProfiles[name];

    term_.setProfile(name);
    term_.prefs_.resetAll();

    for (var name in prefs) {
        term_.prefs_.set(name, prefs[name]);
    }

    term_.prefs_.set('color-palette-overrides', [colors.base02, colors.red,
        colors.green, colors.yellow, colors.blue, colors.magenta, colors.cyan,
        colors.base2, colors.base03, colors.orange, colors.base01, colors.base00,
        colors.base0, colors.violet, colors.base1, colors.base3]);
    term_.prefs_.set('cursor-color', lib.colors.setAlpha(lib.colors.hexToRGB(colors.red), 0.6));

    term_.prefs_.set('font-size', 14);
    term_.prefs_.set('enable-bold', false);
    term_.prefs_.set('font-family', '"Source Code Pro", monospace');
    term_.prefs_.set('font-smoothing', 'subpixel-antialiased');
    term_.prefs_.set('user-css', 'http://fonts.googleapis.com/css?family=Source+Code+Pro|Anonymous+Pro');

    term_.prefs_.set('cursor-blink', true);
    term_.prefs_.set('cursor-blink-cycle', [800, 500]);
    term_.prefs_.set('scrollbar-visible', '');
    term_.prefs_.set('desktop-notification-bell', true);
    term_.prefs_.set('mouse-right-click-paste', false);
};

// restore current profile
term_.setProfile(currentProfile);

// From then on to set the profile at will: `term_.setProfile('profile_name)`,
// e.g.: `term_.setProfile('solarized-dark')`
