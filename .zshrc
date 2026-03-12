DOTFILES_DIR="${HOME}/dotfiles"
export DOTFILES_ENV=$(cat ~/.dotfiles_env)

# Exports
export EDITOR=nvim
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# brew bundle is very quiet otherwise
export HOMEBREW_VERBOSE=1

# Other shell niceties
bindkey -v
bindkey "^R" history-incremental-search-backward
# https://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1
# Allow editing the current command line in $EDITOR with Esc-v.
# This overrides visual mode in vicmd, but I didn't even know that existed.
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Set prompt to [working directory]
export PS1="[%~] "

# Set up history.
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
# > This option works like APPEND_HISTORY except that new history
# > lines are added to the $HISTFILE incrementally (as soon as they
# > are entered), rather than waiting until the shell exits.
setopt INC_APPEND_HISTORY

## Package managers and tool managers

eval "$(/opt/homebrew/bin/brew shellenv)"
# Replaced rbenv and fnm with asdf.

# https://asdf-vm.com/guide/upgrading-to-v0-16
export ASDF_DATA_DIR="/Users/lawrence/.asdf"
export PATH="$ASDF_DATA_DIR/shims:$PATH"

# https://github.com/pyenv/pyenv#basic-github-checkout
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

# Set up completions (this is an incantantion copied from various places).
autoload -Uz compinit && compinit

## Aliases

source "${DOTFILES_DIR}/zsh/alias/git.sh"
source "${DOTFILES_DIR}/zsh/alias/ios.sh"
source "${DOTFILES_DIR}/zsh/alias/ruby.sh"
source "${DOTFILES_DIR}/zsh/alias/other.sh"

source "${DOTFILES_DIR}/zsh/base16-shell.sh"

export PATH="${HOME}/dotfiles/bin:$PATH"

export TMUXINATOR_CONFIG="${DOTFILES_DIR}/tmuxinator"
source "${DOTFILES_DIR}/vendor/tmuxinator.zsh"

# From https://developer.android.com/studio/command-line/variables
export ANDROID_HOME=~/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator:$ANDROID_HOME/platform-tools

[ -f "/Users/lawrence/.ghcup/env" ] && source "/Users/lawrence/.ghcup/env" # ghcup-env
