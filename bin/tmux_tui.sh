#!/bin/bash

set -euo pipefail

if tmux ls &>/dev/null; then
  SESSION=$(tmux list-sessions -F \#S | gum filter --placeholder "Pick session...")
  tmux attach -t "$SESSION"
else
  tmux
fi
