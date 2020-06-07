// Installation: make a symlink from this to the profile directory, something like
// ~/Library/Application Support/Firefox/Profiles/c8csnb2o.default-release-1592253731292

// Confirm it's working by looking at "user.js Preferences" in about:support

// Changes made in Firefox will _not_ be persisted to this file. They will be lost on next launch of Firefox.

user_pref("browser.newtabpage.activity-stream.feeds.section.highlights", false);
user_pref("browser.newtabpage.activity-stream.feeds.snippets", false);
user_pref("browser.newtabpage.activity-stream.feeds.topsites", false);
user_pref("browser.newtabpage.activity-stream.prerender", false);
user_pref("browser.newtabpage.activity-stream.showSearch", false);

// For full-screen in macOS
// user_pref("browser.tabs.closeWindowWithLastTab", false);

user_pref("mousewheel.with_meta.action", 1);
user_pref("mousewheel.with_control.action", 1);
