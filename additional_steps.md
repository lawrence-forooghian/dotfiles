
Steps that need to be performed after install.sh. Some of these could probably be automated:

- TODO how to transfer data over from an old personal machine
  - I think the easiest thing to do is to just plug in Time Machine drive from old machine, copy home directory over to Desktop, and then transfer whatever I want to keep into the new home directory.
- TODO what about Stickies? I have a bunch of stuff there at the moment
- How to set up Time Machine (inherit previous backup?)
- TODO what about stuff in keychain from old machine? There should be nothing that’s only there hopefully, other than Wi-Fi passwords.
- TODO adding SSH key to OptiPlex

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

- Log in to Bitwarden
- Add email accounts
- Install and set up Backblaze
- Set up Alfred (preferences sync) and add Powerpack licence
- Log in to:
  - Slack
  - Spotify
  - Firefox Sync
  - WhatsApp
  - Nextcloud

## Setup of credentials

- [Generate SSH key and add to GitHub](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent), adding the passphrase to Bitwarden
- Switch the origin on ~/dotfiles and ~/code/git-update-messages to use SSH, not HTTPS
- Import GPG key to my GPG keychain (`gpg --import` with the `private.key` stored in Bitwarden)
- Add Brazil digital certificate to keychain

## Processing

- Wait for Backblaze to finish backing up

## Preferences of other software

- Tell Spotify not to start at login
- Set iTerm2 to sync preferences with dotfiles dir

## A possible error

After switching to zsh, you might notice that you get:

```
zsh compinit: insecure directories, run compaudit for list.
Ignore insecure directories and continue [y] or abort compinit [n]? ccompinit: initialization aborted
```

This comment is what I did: https://github.com/zsh-users/zsh-completions/issues/433#issuecomment-600582607

But then Homebrew spat out an error, which I followed:

```
Error: The following directories are not writable by your user:
/usr/local/share/zsh
/usr/local/share/zsh/site-functions

You should change the ownership of these directories to your user.
  sudo chown -R $(whoami) /usr/local/share/zsh /usr/local/share/zsh/site-functions

And make sure that your user has write permission.
  chmod u+w /usr/local/share/zsh /usr/local/share/zsh/site-functions
```

and now everything seems happy.

## Emacs

(Not using it at the moment, just keeping here in case)

M-x package-install:
- evil
- evil-escape
- use-package
- ox-jira
