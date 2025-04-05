// Disable about:config warning
user_pref("browser.aboutConfig.showWarning", false);

// Enable userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Disable menu when pressing alt key.
user_pref("ui.key.menuAccessKeyFocuses", false);

// Allow go/links to work.
// Repeat for any other bare hostnames to allow.
user_pref("browser.fixup.domainwhitelist.go", true);

// Limit scroll distance when "fling" scrolling
// There are additional apz.fling_* options,
// but at a minimum these seem to work well.
user_pref("apz.fling_friction", "0.007");
user_pref("apz.fling_min_velocity_threshold", "1.5");

// Force popup windows to open as normal tabs with URL bar, etc.
user_pref("browser.link.open_newwindow.restriction", 0);

// Use dark theme for private windows
user_pref("browser.theme.dark-private-windows", true);
