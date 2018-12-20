# Universal aliases
alias grep='grep --color=auto'
alias rm='rm -i'
alias lsa='ls -alh'
alias be='bundle exec'

alias genclaco='ruby ~/dotfiles/generate_clang_complete.rb'

# Exports
export EDITOR=vim
export CLICOLOR=1
export LSCOLORS=gxfxcxdxbxegedabagacad

# Other shell niceties
bindkey -v

# Set prompts - nabbed from http://www.edsel.nu/?p=203 until I get round to making one
autoload colors; colors
export PS1="%B[%{$fg[white]%}%n%{$reset_color%}%b@%B%{$fg[white]%}%m%b%{$reset_color%}:%~%B]%b "

# This apparently gives me git completion... erm.
autoload -U compinit && compinit

# Set up history.
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history

# Git aliases
alias gs='git status'
alias gsu='git submodule update --init --recursive'

# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        eval "$("$BASE16_SHELL/profile_helper.sh")"

# init rbenv
eval "$(rbenv init -)"
