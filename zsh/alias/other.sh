alias grep='grep --color=auto'
alias rm='rm -i'
alias lsa='ls -alh'
alias less='less -R' # colors

alias notes='tnr notes && tmux at -t notes'
alias ably='tnr ably/ably-cocoa && tnr ably/ably-js && tnr ably/ably-extras && tnr ably/ably-chat && tnr ably/ably-swift && tnr ably/sdk-workspace && tmux at -t ably-js'

# For starting multiple sessions in one go.
alias tnr="${DOTFILES_DIR}/bin/dotfiles-bundle-exec tmuxinator start --attach false"

# To help me switching over
alias vim="nvim"
