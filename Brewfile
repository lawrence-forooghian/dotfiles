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
cask "calibre" if env.home?
cask "docker"
cask "emacs" # This takes over the `emacs` command line and replaces with GUI
cask "firefox"
cask "google-chrome" if env.work? # Best WebRTC experience (e.g. whereby.com)
cask "hammerspoon"
cask "iterm2"
cask "libreoffice" if env.home?
cask "macdown"
cask "mactex" if env.home?
cask "netnewswire" if env.home?
cask "nextcloud"
cask "obs" # Useful for cropping and zooming webcam
cask "plex-media-server" if env.home?
cask "spotify"
cask "the-unarchiver" if env.home?
cask "transmission" if env.home?
cask "tunnelblick" if env.home?
cask "visual-studio-code" if env.work? # Playing around with JS, not committed to sorting out tooling yet
cask "vlc" if env.home?
cask "whatsapp"
cask "zoom"

brew "ack"
brew "awscli" if env.work?
brew "cmake" # to install Rugged
brew "jakehilborn/jakehilborn/displayplacer" if env.home?
brew "exiftool" # https://exiftool.org/forum/index.php?topic=8652.0
brew "ffmpeg" # Allows youtube-dl to merge best quality audio and video
brew "git" # More up to date than the Apple version
brew "git-absorb"
brew "gpg"
brew "jq" # At least, it does pretty-printing of JSON
brew "mp4v2" # For converting Audible books
brew "ncdu"
brew "nvm" # Will use this to manage node, for dev and for vim-instant-markdown
brew "plantuml" if env.work?
brew "postgres" if env.work?
brew "q" # SQL-like querying of CSV
brew "qpdf" # Used for removing passwords on PDFs: `qpdf --decrypt --replace-input --password=<password> 2020-04.pdf`
brew "rbenv"
brew "reattach-to-user-namespace"
brew "rename" # Used this to rename wedding pics to zero-pad them - https://stackoverflow.com/a/5418035
brew "tmux"
brew "tree"
brew "vim"
brew "youtube-dl" if env.home?
brew "yq" # jq but for YAML

if env.home?
  mas "AdGuard for Safari", id: 1440147259
end
