# Universal aliases
alias grep='grep --color=auto'
alias rm='rm -i'
alias lsa='ls -alh'

alias genclaco='ruby ~/dotfiles/generate_clang_complete.rb'

# Exports
PATH=$HOME/bin:/opt/local/bin:/usr/local/mysql/bin:$HOME/android-sdk-mac_x86/tools:$HOME/android-sdk-mac_x86/platform-tools:/usr/local/sphinx/bin:$PATH
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
