class DotfilesEnv
  attr_reader :env

  def initialize
    # ENV doesn't seem to have DOTFILES_ENV, it seems to be some environment
    # massaged by Homebrew
    @env = File.read("/Users/lawrence/.dotfiles_env").chomp
  end

  def home?
    env == 'home'
  end

  def work?
    env == 'work'
  end
end

env = DotfilesEnv.new

tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/core"

cask "1password"
cask "anki" if env.home?
cask "atom" if env.work? # Used for find and replace
cask "backblaze" if env.home? # Installing because not backed up in ages, I wonder if it will affect battery. Turn off battery mode
cask "calibre" if env.home?
cask "emacs" # This takes over the `emacs` command line and replaces with GUI
cask "firefox" if env.work?
cask "google-chrome" if env.work? # Best WebRTC experience (e.g. whereby.com)
cask "hammerspoon"
cask "iterm2"
cask "libreoffice" if env.home?
cask "macdown"
cask "mactex" if env.home?
cask "nextcloud"
cask "visual-studio-code" if env.work? # Playing around with JS, not committed to sorting out tooling yet
cask "vlc" if env.home?
cask "whatsapp" if env.home?
cask "zoom"

brew "ack"
brew "awscli" if env.work?
brew "ffmpeg" # Allows youtube-dl to merge best quality audio and video
brew "git-absorb"
brew "nvm" # Will use this to manage node, for dev and for vim-instant-markdown
brew "plantuml" if env.work?
brew "postgres" if env.work?
brew "rbenv"
brew "reattach-to-user-namespace"
brew "tmux"
brew "tree"
brew "vim"
brew "youtube-dl" if env.home?

if env.home?
  mas "AdGuard for Safari", id: 1440147259
  mas "EasyRes", id: 688211836
end

# TODO espeak-ng - it's not on homebrew
# TODO espeak normal doesn't come with pt compiled
# cask "turbo-boost-switcher" Using pro instead now
