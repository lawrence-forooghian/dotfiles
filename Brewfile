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
tap "heroku/brew"

cask "alfred"
cask "anki" if env.home?
cask "atom" if env.work? # Used for find and replace
cask "bartender"
cask "bettertouchtool"
# Bitwarden needs to come from Mac App Store to allow biometric authentication, apparently. This is a pain since it’s not always up to date.
#cask "bitwarden" if env.home?
cask "calibre" if env.home?
cask "coconutbattery"
cask "docker"
cask "emacs" # This takes over the `emacs` command line and replaces with GUI
cask "firefox"
cask "freecad"
cask "google-chrome" if env.work? # Best WebRTC experience (e.g. whereby.com)
cask "gpg-suite"
cask "hammerspoon"
cask "imazing" if env.home?
cask "iterm2"
cask "librecad"
cask "libreoffice" if env.home?
cask "macdown"
cask "mactex" if env.home?
cask "mos" # smooth scrolling with 3rd party mouse
cask "msgpack-tools"
cask "netnewswire" if env.home?
cask "nextcloud"
cask "nordvpn"
cask "obs" # Useful for cropping and zooming webcam
cask "plex-media-server" if env.home?
cask "slack" if env.home?
cask "skype" if env.home?
cask "spotify"
cask "the-unarchiver" if env.home?
cask "tomighty"
cask "transmission" if env.home?
cask "tunnelblick" if env.home?
cask "virtualbox" if env.home?
brew "vmware-fusion" # I have a free licence
cask "visual-studio-code" if env.work? # Playing around with JS, not committed to sorting out tooling yet
cask "vlc" if env.home?
cask "whatsapp" if env.home?
cask "zoom"

brew "ack"
brew "awscli" if env.work?
brew "cmake" # to install Rugged
brew "cloc"
brew "jakehilborn/jakehilborn/displayplacer" if env.home?
brew "exiftool" # https://exiftool.org/forum/index.php?topic=8652.0
brew "ffmpeg" # Allows youtube-dl to merge best quality audio and video
brew "fnm"
brew "gh"
brew "git" # More up to date than the Apple version
brew "git-absorb"
brew "heroku"
#brew "gpg" # Not sure if I need this, now I use gpg-suite 
brew "jq" # At least, it does pretty-printing of JSON
brew "mp4v2" # For converting Audible books
brew "ncdu"
brew "plantuml" if env.work?
brew "postgres" if env.work?
brew "pyenv"
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

# TODO if I like Seamly2D, create a cask for it

if env.home?
  mas "AdGuard for Safari", id: 1440147259
  mas "Xcode", id: 497799835
  mas "Reeder", id: 1529448980
  mas "Dark Noise", id: 1465439395
  mas "Bitwarden", id: 1352778147
end
