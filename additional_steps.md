# Additional steps after `install.sh`

Steps that need to be performed after `install.sh`. Some of these could probably be automated:

- Transfer data over from old machine
  - I think the easiest thing to do is to just plug in Time Machine drive from old machine, copy home directory over to Desktop, and then transfer whatever I want to keep into the new home directory.
- Set up Time Machine (use `tmutil inherit '/Volumes/Time Machine'` and then turn on Time Machine, need to give Full Disk Access to iTerm first)
- Check there’s nothing in Stickies on old machine
- Check Keychain on old machine. There should be nothing that’s only there hopefully, other than Wi-Fi passwords.
- Copy over SSH key used for OptiPlex (from Time Machine’s backup) until can set up a new one.

## macOS preferences

- Disable iCloud stuff I don’t want
- Turn on Messages in iCloud
- Turn on FileVault (seems like it’s asked as part of initial setup)
    - TODO what to do with recovery key? Also, it seems that macOS is adding it to iCloud by default (confirm by running `sudo fdesetup list -verbose -extended`) and not telling you it during initial setup
- Disable spellchecking
- Disable guest user
- Whack up the keyboard, trackpad, and mouse speed in OS X
- Set Dock to auto-hide
- Remove default stuff from Dock
- Exclude Terminal from Spotlight -> Privacy
    - You have to drag the Terminal app onto the list
- Disable saving of passwords in Safari (under AutoFill)
- Menu bar icons to turn on:
  - Bluetooth
  - Sound (always)
- Turn on “Use Touch ID for purchases”
- Turn off quick note hot corner
- Set it to lock as soon as lid closed
- Mail: set it to move discarded messages into archive
- Turn off Screen Time (sometimes gets turned on as part of initial setup?)
- Add São Paulo timezone to Calendar
- Disable Holidays calendar
- Disable Siri suggestions in calendar
- Set default calendar in Calendar
- Add home dir to sidebar
- Add Portuguese as a second language
- Turn off “Today Notification” in Reminders
- Change “New Finder windows show” Finder preference to home directory
- Remove Recents from Finder’s sidebar preferences
- Add `~/code` to Finder’s sidebar preferences
- Delete all tags in Finder preferences
- Remove tags from Finder’s sidebar preferences
- Set Finder to always show in List view

  1. Browse to any folder
  2. Choose "Show View Options" in View Menu
  3. Tick "Always open in list view" and "Browse in list view"
  4. Click "Use as Defaults"

- [Stop Option-Space from inserting a non-breaking space](https://superuser.com/a/142573) — these are annoying because they sometimes cause a non-breaking space to be inserting after doing e.g. Option-3 to insert a Markdown heading and then typing a space. (Could automate this one sometime.)

## Setup of other software

- 1Password for Safari — install from App Store
- Log in to 1Password
- Add email accounts
- Install and set up Backblaze
- Install Logitech Options (to get battery level of keyboard)
- Set up Alfred (preferences sync) and add Powerpack licence
- Set up Bartender and add licence
- Add Cyberduck licence
- Log in to:
  - Slack
  - Spotify
  - Firefox Sync
  - WhatsApp
  - Nextcloud
  - Zoom
  - Anki
- Sign in to Apple Developer account in Xcode
- Set IINA as default (it's in its settings)

## Setup of credentials

- [Generate SSH key and add to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent); generate using 1Password
- Fix HTTPS remote URLs so we can push to our repos
  - Both ~/dotfiles and ~/code/personal/git-update-messages are cloned via HTTPS in install.sh (because the SSH key isn't set up yet at that point), which means we can't push to them.
  - For ~/dotfiles: we have to clone via HTTPS (it's needed before SSH is available), so after generating the SSH key, manually switch the remote: `git remote set-url origin git@github.com:lawrence-forooghian/dotfiles.git`
  - For ~/code/personal/git-update-messages: consider deferring the clone until after SSH key setup so it can be cloned via SSH from the start. Alternatively, could move `set_up_git_update_messages` later in install.sh and prompt for SSH key setup first, or just switch the remote URL after the fact like dotfiles.
  - TODO: Improve install.sh to automate this — e.g. add a post-SSH-setup step that switches remotes, or split the script into pre-SSH and post-SSH phases.
- Import GPG key to my GPG keychain (`gpg --import` with the `private.key` stored in 1Password)
- Add Brazil digital certificate to keychain

## Processing

- Wait for Backblaze to finish backing up

## Preferences of other software

- Tell Spotify not to start at login
- Set iTerm2 to sync preferences with dotfiles dir
- Set Parallels VM directory to external drive

## Emacs

(Not using it at the moment, just keeping here in case)

M-x package-install:
- evil
- evil-escape
- use-package
- ox-jira

## Other software to install

- Ivory (Mastodon) — install from App Store
- Focus (for YouTube) — install from App Store (it’s open source; great for blocking all the distracting stuff on YouTube like related videos)
- Kindle — install from App Store
