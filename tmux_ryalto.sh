#!/bin/sh
# Copied from https://gist.github.com/dmkash/2355219

set -e

SESSION_NAME="ryalto"

if tmux has-session -t "${SESSION_NAME}"
then
  echo "Session ${SESSION_NAME} already exists"
else
  # Create the session
  tmux new-session -s ${SESSION_NAME} -n TODO -d

  index=0

  # Create window for notes
  cd ~/org
  tmux new-window -n notes -t "${SESSION_NAME}"
  ((index++))
  tmux send-keys -t "${SESSION_NAME}:${index}" emacs C-m

  # Create window for each service, with vim
  for service in api-service notification-service news_feed ryalto.rb
  do
	cd ~/code/ryalto/backend/${service}
	tmux new-window -n "${service}" -a -t "${SESSION_NAME}"
	((index++))
	tmux send-keys -t "${SESSION_NAME}:${index}" 'vim -c NERDTree' C-m
  done

  # Create window for iOS (TODO why not working?)
  cd ~/code/ryalto/ios/right-nurse-ios
  tmux new-window -n ios -a -t "${SESSION_NAME}"
  #((index++))

  # Kill the initial window
  tmux kill-window -t "${SESSION_NAME}:0"

  # Start out on the first window when we attach
  tmux select-window -t "${SESSION_NAME}:1"
fi
tmux attach -t ${SESSION_NAME}
