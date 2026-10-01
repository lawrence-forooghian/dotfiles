alias grep='grep --color=auto'
alias rm='rm -i'
alias lsa='ls -alh'
alias less='less -R' # colors

# Pipe command output to generate a PDF with colour codes preserved.
# Most commands disable colour when piped, so you'll need to force it.
# Usage: git diff --color | topdf out.pdf
topdf() { aha --word-wrap | weasyprint --stylesheet "${DOTFILES_DIR}/zsh/topdf.css" - "${1:?Usage: some-command | topdf output.pdf}"; }

alias notes='tnr notes && tmux at -t notes'

# For starting multiple sessions in one go.
alias tnr="${DOTFILES_DIR}/bin/dotfiles-bundle-exec tmuxinator start --attach false"

# To help me switching over
alias vim="nvim"
