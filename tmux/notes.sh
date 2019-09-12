#!/bin/sh
# Copied from https://gist.github.com/dmkash/2355219

set -e

SESSION_NAME="notes"

if tmux has-session -t "${SESSION_NAME}"
then
  echo "Session ${SESSION_NAME} already exists"
  exit 1
else
  # Create the session
  tmux new-session -s ${SESSION_NAME} -d

  index=0
  target="${SESSION_NAME}:${index}"

  # Create window for notes
  cd ~/org
  tmux rename-window -t "${TARGET}" notes
  tmux send-keys -t "${TARGET}" 'cd ~/org' 'C-m'
  tmux send-keys -t "${TARGET}" emacs C-m

  ((index++))

  # Create window for dotfiles
  cd ~/dotfiles
  tmux rename-window -t "${TARGET}" dotfiles
  tmux send-keys -t "${TARGET}" 'cd ~/dotfiles' 'C-m'

  ((index++))

  # Start out on the first window when we attach
  tmux select-window -t "${SESSION_NAME}:0"
fi
tmux attach -t ${SESSION_NAME}
