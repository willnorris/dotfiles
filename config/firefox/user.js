// Disable about:config warning
user_pref("browser.aboutConfig.showWarning", false);

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
