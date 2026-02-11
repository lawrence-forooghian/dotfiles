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
cask "arduino" if env.home?
cask "assinador-serpro" if env.home?
cask "backblaze-downloader" if env.home?
cask "bitwise" # Handy for viewing numbers in binary, with easy access to the index of each bit (useful for e.g. bitfields). There are a bunch of tools for doing something similar, including macOS’s built-in Calculator app in Programmer mode; see https://news.ycombinator.com/item?id=34577788
cask "calibre" if env.home? # For some reason this is downloading _really_ slowly
cask "coconutbattery"
cask "cog" if env.home? # open-source music player; plays directly from filesystem, including from zipped albums; seems alright and maintained
cask "cyberduck" if env.home? # GUI for FTP uploads (built-in macOS FTP is read-only)
cask "docker"
cask "drawio"
cask "firefox" # disabled media.av1.enabled because M1 doesn’t have hardware support and some YouTube videos cause CPU usage to skyrocket. With this disabled YouTube uses VP9 instead (same as Safari uses)
cask "foobar2000" if env.home? # free (but not open-source) music player; unlike Cog it indexes your library and lets you search by metadata
cask "gpg-suite"
cask "hammerspoon"
cask "hex-fiend" # Hex editor, also gives `hexf` CLI tool
cask "horos" if env.home? # DICOM viewer (medical exams)
cask "iina" if env.home? # Like VLC but more Mac-like (PIP etc)
cask "inkscape"
cask "iterm2"
cask "keyboardcleantool"
cask "libreoffice" if env.home?
cask "mactex" if env.home?
cask "microsoft-office" if env.home?
cask "mitmproxy"
cask "netnewswire" if env.home?
cask "nmap" if env.home? # Network scanner; e.g. what devices are on network? OpenWRT recommends this for finding your router when you don’t know its IP
cask "nordvpn" if env.home?
cask "obsidian"
cask "parallels" if env.home?
cask "qflipper" if env.home?
cask "qlmarkdown" # Quick Look for Markdown
cask "sf-symbols"
cask "slack"
cask "spotify"
# This has recently started showing ads, don't trust it any more
# cask "the-unarchiver" if env.home?
cask "tomighty"
cask "transmission" if env.home?
cask "transmission-remote-gui" if env.home?
cask "tunnelblick" if env.home?
cask "visual-studio-code" if env.work? # Playing around with JS, not committed to sorting out tooling yet
cask "vlc" if env.home?
cask "whatsapp" if env.home?
cask "wireshark"
cask "xact" if env.home? # for e.g. converting to FLAC, adding tags
cask "xcodes"
cask "zoom"

brew "ack"
brew "aria2" # For faster downloading with `xcodes`
brew "asdf"
brew "awscli" if env.work?
brew "cloc"
brew "cmake" # to install Rugged
brew "exiftool" # if env.home? https://exiftool.org/forum/index.php?topic=8652.0
brew "ffmpeg" if env.home? # Allows youtube-dl to merge best quality audio and video
brew "fluidsynth" if env.home? # For Haskell School of Music book
brew "fnm"
brew "gh"
brew "ghcup" if env.home? # Haskell version manager (for Haskell School of Music book)
brew "git" # More up to date than the Apple version
brew "git-absorb"
brew "go"
brew "gramps" if env.home? # Family tree; after this, install the Graph View addon because it lets you see the whole tree and not just the ancestors of a single person (which is what the default Pedigree view gives you)
brew "gnu-sed" # I don’t want to try and learn two seds right now
brew "gnu-typist" if env.home?
brew "graphviz"
brew "heroku"
brew "imagemagick"
brew "inetutils" # ftp, telnet
brew "ipcalc" # handy calculator for e.g. deciphering CIDR notation
brew "iperf" # Measuring transfer speed between two hosts (the other running an iperf server)
brew "jakehilborn/jakehilborn/displayplacer" if env.home?
brew "jq" # At least, it does pretty-printing of JSON
brew "mediainfo" if env.home? # Print information about media files e.g. the Dolby Vision profile
brew "mp4v2" if env.home? # For converting Audible books
brew "msgpack-tools" # msgpack2json, json2msgpack
brew "ncdu"
brew "neovim"
brew "ocrmypdf" if env.home?
brew "pandoc" if env.home? # Used for my CV
brew "plantuml" if env.work?
brew "postgresql@14" if env.work?
brew "pyenv"
brew "speedtest"
brew "q" # SQL-like querying of CSV
# Used for:
# - removing passwords on PDFs: `qpdf --decrypt --replace-input --password=<password> 2020-04.pdf`
# - merging PDFs: `qpdf --empty --pages *.pdf -- merged.pdf`
brew "qpdf" if env.home?
brew "rbenv"
brew "reattach-to-user-namespace"
brew "rename" if env.home? # Used this to rename wedding pics to zero-pad them - https://stackoverflow.com/a/5418035
brew "robotsandpencils/made/xcodes" # TODO fix – You need Xcode installed to install xcodes on M1: https://github.com/RobotsAndPencils/homebrew-made/issues/3, so to bootstrap things on a new machine I downloaded the xcodes binary from GitHub, put it in ~/dotfiles/bin, installed Xcode, then removed from ~/dotfiles/bin and installed using Homebrew.
brew "spek" if env.home? # spectrum analyser, useful for seeing if an audio file is lossless
brew "streamlink" if env.home? # For downloading e.g. HLS streams
brew "tesseract-lang" if env.home? # All languages for OCRmyPDF
brew "tmux"
brew "tree"
brew "vapor"
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
