class DotfilesEnv
  attr_reader :env

  def initialize
    # ENV doesn't seem to have DOTFILES_ENV, it seems to be some environment
    # massaged by Homebrew
    @env = File.read("/Users/lawrence/.dotfiles_env").chomp
  end

  # The 'all' env is used for when I’m contracting and using a single machine
  # for personal + work

  def home?
    return true

    env == 'home' || env == 'all'
  end

  def work?
    return true

    env == 'work' || env == 'all'
  end
end

env = DotfilesEnv.new

tap "homebrew/bundle"
tap "homebrew/cask"
tap "homebrew/core"
tap "jakehilborn/jakehilborn"
tap "heroku/brew"

cask "adobe-acrobat-reader"
cask "alfred"
cask "android-studio" # For Ably Android stuff
cask "anki" if env.home?
cask "arduino"
cask "assinador-serpro"
cask "bartender"
cask "calibre" if env.home?
cask "coconutbattery"
cask "cyberduck" # GUI for FTP uploads (built-in macOS FTP is read-only)
cask "discord"
cask "docker"
cask "emacs" # This takes over the `emacs` command line and replaces with GUI
cask "element" # For Bitwarden discussion
cask "firefox"
cask "google-chrome" if env.work? # Best WebRTC experience (e.g. whereby.com)
cask "gpg-suite"
cask "hammerspoon"
cask "hakuneko" if env.home?
cask "iterm2"
cask "librecad"
cask "libreoffice" if env.home?
cask "macdown"
cask "mactex" if env.home?
cask "microsoft-office"
cask "mos" # smooth scrolling with 3rd party mouse
cask "netnewswire" if env.home?
cask "nextcloud"
cask "nordvpn"
cask "obs" # Useful for cropping and zooming webcam
cask "sf-symbols"
cask "skype" if env.home?
cask "slack" if env.home?
cask "spotify"
cask "the-unarchiver" if env.home?
cask "tomighty"
cask "transmission" if env.home?
cask "transmission-remote-gui"
cask "tunnelblick" if env.home?
cask "vagrant"
cask "vapor"
cask "visual-studio-code" if env.work? # Playing around with JS, not committed to sorting out tooling yet
cask "vlc" if env.home?
cask "vmware-fusion" # I have a free licence
cask "whatsapp" if env.home?
cask "xcodes"
cask "zoom"

brew "ack"
brew "aria2" # For faster downloading with `xcodes`
brew "awscli" if env.work?
brew "cloc"
brew "cmake" # to install Rugged
brew "exiftool" # https://exiftool.org/forum/index.php?topic=8652.0
brew "ffmpeg" # Allows youtube-dl to merge best quality audio and video
brew "fnm"
brew "gh"
brew "git" # More up to date than the Apple version
brew "git-absorb"
brew "gnu-sed" # I don’t want to try and learn two seds right now
brew "heroku"
brew "inetutils" # ftp, telnet
brew "jakehilborn/jakehilborn/displayplacer" if env.home?
brew "jq" # At least, it does pretty-printing of JSON
brew "mp4v2" # For converting Audible books
brew "msgpack-tools"
brew "ncdu"
brew "ocrmypdf"
brew "plantuml" if env.work?
brew "postgresql@14" if env.work?
brew "pyenv"
brew "q" # SQL-like querying of CSV
brew "qpdf" # Used for removing passwords on PDFs: `qpdf --decrypt --replace-input --password=<password> 2020-04.pdf`
brew "rbenv"
brew "reattach-to-user-namespace"
brew "rename" # Used this to rename wedding pics to zero-pad them - https://stackoverflow.com/a/5418035
brew "robotsandpencils/made/xcodes" # TODO fix – You need Xcode installed to install xcodes on M1: https://github.com/RobotsAndPencils/homebrew-made/issues/3, so to bootstrap things on a new machine I downloaded the xcodes binary from GitHub, put it in ~/dotfiles/bin, installed Xcode, then removed from ~/dotfiles/bin and installed using Homebrew.
brew "tesseract-lang" # All languages for OCRmyPDF
brew "tmux"
brew "tree"
brew "vim"
brew "watchman" # For Command-T
brew "xcbeautify" # Used by ably-cocoa build
brew "youtube-dl" if env.home?
brew "yq" # jq but for YAML

# TODO if I like Seamly2D / Valentina, create a cask for it

if env.home?
  mas "Reeder", id: 1529448980
  mas "Dark Noise", id: 1465439395
  # Bitwarden needs to come from Mac App Store to allow biometric authentication, apparently. This is a pain since it’s not always up to date.
  mas "Bitwarden", id: 1352778147
  mas "DevCleaner", id: 1388020431
  mas "Yubico Authenticator", id: 1497506650
  mas "Kindle", id: 405399194
end
