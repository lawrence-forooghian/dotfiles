DOTFILES_DIR="${HOME}/dotfiles"
export DOTFILES_ENV=$(cat ~/.dotfiles_env)

# Exports
export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# brew bundle is very quiet otherwise
export HOMEBREW_VERBOSE=1

# Other shell niceties
bindkey -v
bindkey "^R" history-incremental-search-backward
# https://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1

# Set prompts - nabbed from http://www.edsel.nu/?p=203 until I get round to making one
autoload colors; colors
export PS1="%B[%{$fg[white]%}%n%{$reset_color%}%b@%B%{$fg[white]%}%m%b%{$reset_color%}:%~%B]%b "

# Set up history.
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

## Package managers and tool managers

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init -)"
eval "$(fnm env --use-on-cd)"

# https://asdf-vm.com/guide/getting-started.html#_3-install-asdf
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)

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
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools
