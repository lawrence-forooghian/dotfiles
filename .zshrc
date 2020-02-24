DOTFILES_DIR="${HOME}/dotfiles"

# Exports
export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Other shell niceties
bindkey -v
bindkey "^R" history-incremental-search-backward
# https://dougblack.io/words/zsh-vi-mode.html
export KEYTIMEOUT=1

# Set prompts - nabbed from http://www.edsel.nu/?p=203 until I get round to making one
autoload colors; colors
export PS1="%B[%{$fg[white]%}%n%{$reset_color%}%b@%B%{$fg[white]%}%m%b%{$reset_color%}:%~%B]%b "

# This apparently gives me git completion... erm.
autoload -U compinit && compinit

# Set up history.
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# init rbenv
eval "$(rbenv init -)"

## Aliases

# Git aliases
alias gs='git status'
alias gsu='git submodule update --init --recursive'
alias gri='git rebase -i origin/master'
alias gpu='git push -u origin HEAD'
alias gpf='git push --force-with-lease'
alias gf='git fetch origin'

# Ruby aliases
alias be='bundle exec'
alias rc='bundle exec rubocop -a'
alias sf='bundle exec standardrb --fix'

# iOS aliases
alias pi='bundle exec pod install'

# Universal aliases
alias grep='grep --color=auto'
alias rm='rm -i'
alias lsa='ls -alh'
alias less='less -R' # colors

# https://github.com/pyenv/pyenv#basic-github-checkout
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Base16 Shell
BASE16_SHELL="${DOTFILES_DIR}/vendor/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

base16_default-dark

export PATH="${PATH}:/Applications/Postgres.app/Contents/Versions/latest/bin:${DOTFILES_DIR}/git-commands"

# Generate tags for a Rails project
# https://blog.sensible.io/2014/05/09/supercharge-your-vim-into-ide-with-ctags.html
alias rtgen='ctags -R --languages=ruby --exclude=.git --exclude=log .'

export TMUXINATOR_CONFIG="${DOTFILES_DIR}/tmuxinator"
source "${DOTFILES_DIR}/vendor/tmuxinator.zsh"
# For starting multiple sessions in one go.
alias tnr='tmuxinator start --attach=false'

# https://stackoverflow.com/questions/38725102/how-to-add-custom-git-command-to-zsh-completion
zstyle ':completion:*:*:git:*' user-commands update-messages:'after a rebase, fix commit messages which contain outdated references to other commits'
