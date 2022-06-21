- TODO how to transfer data over from an old personal machine, and how to set up time machine
- TODO write an install script that means my password manager is installed before I need to start adding SSH keys to GitHub etc

Steps that need to be performed after install.sh. Some of these could probably be automated:

- TODO generating SSH key, adding to accounts
- TODO what about GPG key?
- Get dotfiles and run install script
- symlink user.js into Firefox profile
- create ~/.gitconfig_local
- clone git-update-messages so that hooks work, and rbenv / bundle install there
- set up time machine
- TODO what about stuff in keychain from old machine? There should be nothing that’s only there hopefully. Also what about Wi-Fi passwords? Perhaps export Perhaps just copy over keychain from old machine.

## macOS preferences

- Disable iCloud stuff I don’t want
- Turn on FileVault
    - TODO what to do with recovery key?
- Disable spellchecking
- Disable guest user
- Whack up the keyboard, trackpad, and mouse speed in OS X
- Set Dock to auto-hide
- Remove default stuff from Dock
- Exclude Terminal from Spotlight -> Privacy

## Setup of other software

- Add email accounts
- Install and set up Backblaze
- Log in to Bitwarden
- Set up Alfred (preferences sync) and add Powerpack licence
- Log in to:
  - Slack
  - Spotify
  - Firefox Sync
  - WhatsApp

## Preferences of other software

- Tell Spotify not to start at login
- Set iTerm2 to sync preferences with dotfiles dir

## A possible error

After switching to zsh, you might notice that you get:

zsh compinit: insecure directories, run compaudit for list.
Ignore insecure directories and continue [y] or abort compinit [n]? ccompinit: initialization aborted

This comment is what I did: https://github.com/zsh-users/zsh-completions/issues/433#issuecomment-600582607

But then Homebrew spat out an error, which I followed:

Error: The following directories are not writable by your user:
/usr/local/share/zsh
/usr/local/share/zsh/site-functions

You should change the ownership of these directories to your user.
  sudo chown -R $(whoami) /usr/local/share/zsh /usr/local/share/zsh/site-functions

And make sure that your user has write permission.
  chmod u+w /usr/local/share/zsh /usr/local/share/zsh/site-functions

and now everything seems happy
