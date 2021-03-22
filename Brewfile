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
tap "jakehilborn/jakehilborn"

cask "1password"
cask "alfred"
cask "anki" if env.home?
cask "atom" if env.work? # Used for find and replace
#cask "backblaze" if env.home? # This is no use - it asks you to manually run an installer, which is just gonna get lost in `brew bundle` output. Install manually.
cask "calibre" if env.home?
cask "emacs" # This takes over the `emacs` command line and replaces with GUI
cask "firefox" if env.work?
cask "google-chrome" if env.work? # Best WebRTC experience (e.g. whereby.com)
cask "hammerspoon"
cask "iterm2"
cask "libreoffice" if env.home?
cask "macdown"
cask "mactex" if env.home?
cask "netnewswire" if env.home?
cask "nextcloud"
cask "spotify"
cask "the-unarchiver" if env.home?
cask "transmission" if env.home?
cask "visual-studio-code" if env.work? # Playing around with JS, not committed to sorting out tooling yet
cask "vlc" if env.home?
cask "whatsapp" if env.home?
cask "zoom"

brew "ack"
brew "awscli" if env.work?
brew "cmake" # to install Rugged
brew "displayplacer" if env.home?
brew "ffmpeg" # Allows youtube-dl to merge best quality audio and video
brew "git" # More up to date than the Apple version
brew "git-absorb"
brew "gpg"
brew "jq" # At least, it does pretty-printing of JSON
brew "ncdu"
brew "nvm" # Will use this to manage node, for dev and for vim-instant-markdown
brew "plantuml" if env.work?
brew "postgres" if env.work?
brew "q" # SQL-like querying of CSV
brew "rbenv"
brew "reattach-to-user-namespace"
brew "tmux"
brew "tree"
brew "vim"
brew "youtube-dl" if env.home?
brew "yq" # jq but for YAML

if env.home?
  mas "AdGuard for Safari", id: 1440147259
end
