#!/bin/bash

set -euo pipefail

SESSION=$(tmux list-sessions -F \#S | gum filter --placeholder "Pick session...")
tmux attach -t "$SESSION"
