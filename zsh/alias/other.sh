alias grep='grep --color=auto'
alias rm='rm -i'
alias lsa='ls -alh'
alias less='less -R' # colors

alias notes='tnr notes && tmux at -t notes'
alias ably='tnr ably/ably && tnr ably/ably-extras && tnr ably/ably-asset-tracking && tmux at -t ably'

# For starting multiple sessions in one go.
alias tnr="${DOTFILES_DIR}/bin/dotfiles-bundle-exec tmuxinator start --attach false"
