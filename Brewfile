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
tap "teamookla/speedtest"

cask "1password"
cask "alfred"
cask "android-studio" # For Ably Android stuff
cask "anki" if env.home?
cask "arduino"
cask "assinador-serpro"
cask "backblaze-downloader"
cask "calibre" if env.home? # For some reason this is downloading _really_ slowly
cask "coconutbattery"
cask "cog" # open-source music player; plays directly from filesystem, including from zipped albums; seems alright and maintained
cask "cyberduck" # GUI for FTP uploads (built-in macOS FTP is read-only)
cask "docker"
cask "drawio"
cask "epic-games" # For Unreal Engine
cask "firefox" # disabled media.av1.enabled because M1 doesn’t have hardware support and some YouTube videos cause CPU usage to skyrocket. With this disabled YouTube uses VP9 instead (same as Safari uses)
cask "foobar2000" # free (but not open-source) music player; unlike Cog it indexes your library and lets you search by metadata
cask "gpg-suite"
cask "hammerspoon"
cask "hex-fiend" # Hex editor, also gives `hexf` CLI tool
cask "horos" # DICOM viewer (medical exams)
cask "iina" # Like VLC but more Mac-like (PIP etc)
cask "inkscape"
cask "iterm2"
cask "keyboardcleantool"
cask "libreoffice" if env.home?
cask "mactex" if env.home?
cask "microsoft-office"
cask "mitmproxy"
cask "netnewswire"
cask "nordvpn"
cask "obsidian"
cask "parallels"
cask "qflipper"
cask "qlmarkdown" # Quick Look for Markdown
cask "sf-symbols"
cask "skype" if env.home?
cask "slack" if env.home?
cask "sony-ps-remote-play"
cask "spotify"
cask "steam"
cask "the-unarchiver" if env.home?
cask "tomighty"
cask "transmission" if env.home?
cask "transmission-remote-gui"
cask "tunnelblick" if env.home?
cask "vagrant"
cask "virtualbuddy" # Easy way to make macOS virtual machines
cask "visual-studio-code" if env.work? # Playing around with JS, not committed to sorting out tooling yet
cask "vlc" if env.home?
cask "whatsapp" if env.home?
cask "wireshark"
cask "xact" # for e.g. converting to FLAC, adding tags
cask "xcodes"
cask "zoom"

brew "ack"
brew "aria2" # For faster downloading with `xcodes`
brew "awscli" if env.work?
brew "cloc"
brew "cmake" # to install Rugged
brew "exiftool" # https://exiftool.org/forum/index.php?topic=8652.0
brew "ffmpeg" # Allows youtube-dl to merge best quality audio and video
brew "fluidsynth" # For Haskell School of Music book
brew "fnm"
brew "gh"
brew "ghcup" # Haskell version manager (for Haskell School of Music book)
brew "git" # More up to date than the Apple version
brew "git-absorb"
brew "go"
brew "gnu-sed" # I don’t want to try and learn two seds right now
brew "gnu-typist"
brew "graphviz"
brew "heroku"
brew "imagemagick"
brew "inetutils" # ftp, telnet
brew "ipcalc" # handy calculator for e.g. deciphering CIDR notation
brew "iperf" # Measuring transfer speed between two hosts (the other running an iperf server)
brew "jakehilborn/jakehilborn/displayplacer" if env.home?
brew "jq" # At least, it does pretty-printing of JSON
brew "mp4v2" # For converting Audible books
brew "msgpack-tools" # msgpack2json, json2msgpack
brew "ncdu"
brew "neovim"
brew "ocrmypdf"
brew "pandoc" # Used for my CV
brew "plantuml" if env.work?
brew "postgresql@14" if env.work?
brew "pyenv"
brew "speedtest"
brew "q" # SQL-like querying of CSV
# Used for:
# - removing passwords on PDFs: `qpdf --decrypt --replace-input --password=<password> 2020-04.pdf`
# - merging PDFs: `qpdf --empty --pages *.pdf -- merged.pdf`
brew "qpdf"
brew "rbenv"
brew "reattach-to-user-namespace"
brew "rename" # Used this to rename wedding pics to zero-pad them - https://stackoverflow.com/a/5418035
brew "robotsandpencils/made/xcodes" # TODO fix – You need Xcode installed to install xcodes on M1: https://github.com/RobotsAndPencils/homebrew-made/issues/3, so to bootstrap things on a new machine I downloaded the xcodes binary from GitHub, put it in ~/dotfiles/bin, installed Xcode, then removed from ~/dotfiles/bin and installed using Homebrew.
brew "spek" # spectrum analyser, useful for seeing if an audio file is lossless
brew "streamlink" # For downloading e.g. HLS streams
brew "tesseract-lang" # All languages for OCRmyPDF
brew "tmux"
brew "tree"
brew "vapor"
brew "vim"
brew "xcbeautify" # Used by ably-cocoa build
brew "ykman" # YubiKey Manager CLI
brew "yt-dlp" if env.home?
brew "yq" # jq but for YAML

# TODO if I like Seamly2D / Valentina, create a cask for it

if env.home?
  mas "Reeder", id: 1529448980
  mas "Dark Noise", id: 1465439395
  mas "DevCleaner", id: 1388020431
  mas "Yubico Authenticator", id: 1497506650
  mas "Broadcasts", id: 1469995354

  # mas doesn’t currently support installing iOS apps (https://github.com/mas-cli/mas/issues/321#issuecomment-804546339);
  # macOS gives a "Current Version Not Compatible" error
  # mas "Overcast", id: 888422857
end
