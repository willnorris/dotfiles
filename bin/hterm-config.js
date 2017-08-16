// Run in the JavaScript console of the hterm browser window

// Modified from https://gist.github.com/russelldavies/5745528

// Clear all existing settings - you probably don't want to do this.
// Preferences are now stored in "chrome.storage.sync" instead of
// "window.localStorage" so if you clear your preferences the changes
// will be propagated to other devices.
//term_.prefs_.storage.clear();


var htermProfiles = [
    // Solarized Dark
    {
        'name': 'solarized-dark',
        'prefs': {
            'background-color': '#002b36',
            'foreground-color': '#839496',
            'cursor-color': 'rgba(131, 148, 150, 0.5)',
        },
    },
    // Solarized Light
    {
        'name': 'solarized-light',
        'prefs': {
            'background-color': '#fdf6e3',
            'foreground-color': '#657b83',
            'cursor-color': 'rgba(101, 123, 131, 0.5)',
        },
    },
];

htermProfiles.forEach(function(profile) {
    term_.setProfile(profile.name);
    term_.prefs_.resetAll();

    for (var name in profile.prefs) {
        term_.prefs_.set(name, profile.prefs[name]);
    }

    term_.prefs_.set('color-palette-overrides', ['#073642', '#dc322f',
        '#859900', '#b58900', '#268bd2', '#d33682', '#2aa198', '#eee8d5',
        '#002b36', '#cb4b16', '#586e75', '#657b83', '#839496', '#6c71c4',
        '#93a1a1', '#fdf6e3']);
    term_.prefs_.set('font-size', 12);
    term_.prefs_.set('enable-bold', false);
    //term_.prefs_.set('font-family', 'Menlo');
    term_.prefs_.set('font-smoothing', 'subpixel-antialiased');
});

// From then on to set the profile at will: `term_.setProfile('profile_name)`,
// e.g.: `term_.setProfile('solarized-dark')`
