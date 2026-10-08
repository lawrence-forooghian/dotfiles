class DotfilesEnv
  attr_reader :env

  def initialize
    # ENV doesn't seem to have DOTFILES_ENV, it seems to be some environment
    # massaged by Homebrew
    @env = File.read(File.join(Dir.home, ".dotfiles_env")).chomp
  end

  # The 'all' env is used for when I’m contracting and using a single machine
  # for personal + work

  def home?
    env == 'home' || env == 'all'
  end

  def work?
    env == 'work' || env == 'all'
  end
end

env = DotfilesEnv.new

# Installed on all machines

cask "1password"
cask "alfred"
cask "ArtemYurov/tomobar/tomobar" # Replacement for Tomighty, which is not Gatekeepered
cask "docker-desktop"
cask "firefox" # disabled media.av1.enabled because M1 doesn’t have hardware support and some YouTube videos cause CPU usage to skyrocket. With this disabled YouTube uses VP9 instead (same as Safari uses)
cask "hammerspoon"
cask "iterm2"
cask "obsidian"
cask "xcodes-app"
cask "zoom"

brew "ack"
brew "aria2" # For faster downloading with `xcodes`
brew "asdf"
brew "bitwise" # Handy for viewing numbers in binary, with easy access to the index of each bit (useful for e.g. bitfields). There are a bunch of tools for doing something similar, including macOS’s built-in Calculator app in Programmer mode; see https://news.ycombinator.com/item?id=34577788
brew "cloc"
brew "cmake" # to install Rugged
brew "gh"
brew "git" # More up to date than the Apple version
brew "git-absorb"
brew "gnu-sed" # I don’t want to try and learn two seds right now
brew "imagemagick"
brew "inetutils" # ftp, telnet
brew "ipcalc" # handy calculator for e.g. deciphering CIDR notation
brew "jq" # At least, it does pretty-printing of JSON
brew "libyaml" # Appears to be needed for asdf's installation of Ruby to succeed
brew "msgpack-tools" # msgpack2json, json2msgpack
brew "ncdu"
brew "neovim"
brew "pyenv"
brew "q" # SQL-like querying of CSV
brew "reattach-to-user-namespace"
brew "xcodes" # TODO: Check what is the right one — this is the only one I found that didn't require me to install xcode first (different to the one on their GitHub, i.e. xcodesorg/xcodes
brew "tmux"
brew "tree"
brew "yq" # jq but for YAML

# Installed on home machines only

if env.home?
  cask "anki"
  cask "arduino"
  # cask "assinador-serpro" # This cask has been disabled for some reason and not updated since 4.3.3 (4.5.0 is now available)
  cask "backblaze-downloader"
  cask "calibre" # For some reason this is downloading _really_ slowly
  cask "coconutbattery"
  cask "cog" # open-source music player; plays directly from filesystem, including from zipped albums; seems alright and maintained
  cask "cyberduck" # GUI for FTP uploads (built-in macOS FTP is read-only)
  cask "drawio"
  cask "foobar2000" # free (but not open-source) music player; unlike Cog it indexes your library and lets you search by metadata
  cask "gpg-suite"
  cask "hex-fiend" # Hex editor, also gives `hexf` CLI tool
  cask "horos" # DICOM viewer (medical exams)
  cask "iina" # Like VLC but more Mac-like (PIP etc)
  cask "inkscape"
  cask "keyboardcleantool"
  cask "libreoffice"
  cask "mactex"
  cask "microsoft-office"
  cask "netnewswire"
  cask "nmap" # Network scanner; e.g. what devices are on network? OpenWRT recommends this for finding your router when you don’t know its IP
  cask "obs" # Useful for recording a single window for demos etc (the built-in one recording tool either does full screen or fiddly dragging of a selection rectangle)
  cask "parallels"
  cask "qflipper"
  cask "sf-symbols"
  cask "spotify"
  # This has recently started showing ads, don't trust it any more
  # cask "the-unarchiver"
  cask "transmission"
  cask "transmission-remote-gui"
  cask "tunnelblick"
  cask "vlc"
  cask "voiceink"
  cask "whatsapp"
  cask "wireshark-app"
  cask "xact" # for e.g. converting to FLAC, adding tags

  brew "aha" # Converts ANSI to HTML — used for generating PDFs from Git diffs for review on iPad
  brew "weasyprint" # HTML to PDF — used by topdf alias
  brew "exiftool" # https://exiftool.org/forum/index.php?topic=8652.0
  brew "ffmpeg" # Allows youtube-dl to merge best quality audio and video
  brew "fluidsynth" # For Haskell School of Music book
  brew "ghcup" # Haskell version manager (for Haskell School of Music book)
  brew "go"
  brew "gramps" # Family tree; after this, install the Graph View addon because it lets you see the whole tree and not just the ancestors of a single person (which is what the default Pedigree view gives you)
  brew "gnu-typist"
  brew "graphviz"
  brew "iperf" # Measuring transfer speed between two hosts (the other running an iperf server)
  brew "displayplacer"
  brew "mediainfo" # Print information about media files e.g. the Dolby Vision profile
  brew "mp4v2" # For converting Audible books
  brew "ocrmypdf"
  brew "pandoc" # Used for my CV
  brew "teamookla/speedtest/speedtest"
  # Used for:
  # - removing passwords on PDFs: `qpdf --decrypt --replace-input --password=<password> 2020-04.pdf`
  # - merging PDFs: `qpdf --empty --pages *.pdf -- merged.pdf`
  brew "qpdf"
  brew "rename" # Used this to rename wedding pics to zero-pad them - https://stackoverflow.com/a/5418035
  brew "spek" # spectrum analyser, useful for seeing if an audio file is lossless
  brew "streamlink" # For downloading e.g. HLS streams
  brew "tesseract-lang" # All languages for OCRmyPDF
  brew "ykman" # YubiKey Manager CLI
  brew "yt-dlp"

  # TODO if I like Seamly2D / Valentina, create a cask for it

  mas "Reeder", id: 1529448980
  mas "Dark Noise", id: 1465439395
  mas "DevCleaner", id: 1388020431
  mas "Yubico Authenticator", id: 1497506650
  mas "Broadcasts", id: 1469995354

  # mas doesn’t currently support installing iOS apps (https://github.com/mas-cli/mas/issues/321#issuecomment-804546339);
  # macOS gives a "Current Version Not Compatible" error
  # mas "Overcast", id: 888422857
end

# Installed on work machines only

if env.work?
  cask "visual-studio-code"
end
