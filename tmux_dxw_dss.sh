#!/bin/sh
# Copied from https://gist.github.com/dmkash/2355219

set -e

SESSION_NAME="dxw-dss"

if tmux has-session -t "${SESSION_NAME}"
then
  echo "Session ${SESSION_NAME} already exists"
  exit 1
else
  # Create the session
  tmux new-session -s ${SESSION_NAME} -n TODO -d

  index=0

  # Create window for notes
  cd ~/org
  tmux new-window -n notes -t "${SESSION_NAME}"
  ((index++))
  tmux send-keys -t "${TARGET}" emacs C-m

  target="${SESSION_NAME}:${index}"

  # Create window for each service, with splits and vim in the largest pane
  for service in DataSubmissionService DataSubmissionServiceAPI
  do
	cd ~/code/${service}
	tmux new-window -n "${service}" -a -t "${SESSION_NAME}"
	((index++))

	tmux split-window -h -t "${TARGET}"
	tmux split-window -t "${TARGET}"

	tmux selectp -L -t "${TARGET}"
	tmux send-keys -t "${TARGET}" 'vim -c NERDTree' C-m
  done

  # Create window for service manual
  cd ~/code/ReportMI-service-manual
  tmux new-window -n manual -a -t "${SESSION_NAME}"
  ((index++))

  # Kill the initial window
  tmux kill-window -t "${SESSION_NAME}:0"

  # Start out on the first window when we attach
  tmux select-window -t "${SESSION_NAME}:1"
fi
tmux attach -t ${SESSION_NAME}
