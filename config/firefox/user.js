// Disable about:config warning
user_pref("browser.aboutConfig.showWarning", false);

// Enable userChrome.css
user_pref("toolkit.legacyUserProfileCustomizations.stylesheets", true);

// Disable menu when pressing alt key.
user_pref("ui.key.menuAccessKeyFocuses", false);

// Allow go/links to work.
// Repeat for any other bare hostnames to allow.
user_pref("browser.fixup.domainwhitelist.go", true);
user_pref("browser.fixup.domainwhitelist.who", true);

// Limit scroll distance when "fling" scrolling
// There are additional apz.fling_* options,
// but at a minimum these seem to work well.
user_pref("apz.fling_friction", "0.007");
user_pref("apz.fling_min_velocity_threshold", "1.5");

// Force popup windows to open as normal tabs with URL bar, etc.
user_pref("browser.link.open_newwindow.restriction", 0);

// Use dark theme for private windows
user_pref("browser.theme.dark-private-windows", true);

// Enable vertical tabs
user_pref("sidebar.verticalTabs", true);
user_pref("sidebar.revamp", true);
user_pref("sidebar.main.tools", "");

// Enable tab groups
user_pref("browser.tabs.groups.enabled", true);

// Set blank page as homepage.
user_pref("browser.startup.homepage", "chrome://browser/content/blanktab.html");

// hide shortcuts at bottom of expanded URL bar
user_pref("browser.urlbar.shortcuts.bookmarks", false);
user_pref("browser.urlbar.shortcuts.history", false);
user_pref("browser.urlbar.shortcuts.tabs", false);
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false);
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);

user_pref("browser.toolbars.bookmarks.visibility", "never");

// turn off data reporting
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("datareporting.usage.uploadEnabled", false);

// disable form fill and password management
user_pref("extensions.formautofill.addresses.enabled", false);
user_pref("extensions.formautofill.creditCards.enabled", false);
user_pref("signon.rememberSignons", false);
user_pref("signon.management.page.breach-alerts.enabled", false);
