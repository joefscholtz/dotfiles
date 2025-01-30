# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

export PATH=$HOME/.cargo/bin:$HOME/bin:/usr/local/bin:$PATH

source $HOME/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOME/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOME/.config/zsh/zsh-vi-mode/zsh-vi-mode.zsh
ZVM_VI_HIGHLIGHT_FOREGROUND=#cdd6f4           # Hex value
ZVM_VI_HIGHLIGHT_BACKGROUND=#fc78c4           # Hex value
ZVM_VI_HIGHLIGHT_EXTRASTYLE=bold    # bold
ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BEAM
ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_BLOCK
ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLOCK

#zsh history
HISTDUP=erase
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

export FPATH="$HOME/.config/zsh/eza/completions/zsh:$FPATH"

# bun completions
[ -s "/home/joe/.bun/_bun" ] && source "/home/joe/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#aliases
alias ros2topics='watch -n 0.1 ros2 topic list'
alias clip='xclip -sel clip'
alias nv="nvim"
alias l="ls -a"
alias ll="ls -al"

#virtualenvwrapper export WORKON_HOME=$HOME/.virtualenvs && source /usr/share/virtualenvwrapper/virtualenvwrapper.sh
. "$HOME/.cargo/env"

#starship
eval "$(starship init zsh)"

#zoxide
eval "$(zoxide init zsh)"
alias cd="z"

#bat
alias cat="batcat"

alias rgf="rg --color=always --line-number --no-heading --smart-case '${*:-}' |
  fzf --ansi \
      --color 'hl:-1:underline,hl+:-1:underline:reverse' \
      --delimiter : \
      --preview 'batcat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'"

alias j="just"
#ros
export ROS_DOMAIN_ID=11
. /opt/ros/humble/setup.zsh
#. /home/joe/jaguar_ws/install/local_setup.bash
# . /home/joe/mapping_ws/install/local_setup.bash
# . /home/joe/outdoor_ws/install/local_setup.bash
# . /home/joe/ros2_ws/install/local_setup.zsh
# . /home/joe/livox_ros_driver2_ws/install/local_setup.zsh

# . /home/joe/outside_git/ros2_ws/install/local_setup.zsh
# . /home/joe/outside_git/ros2_ws/src/bringup/install/local_setup.zsh
. /home/joe/drc_git/drc_ws/install/local_setup.zsh
. /home/joe/vba_git/vba_ws/install/local_setup.zsh
. /usr/share/gazebo/setup.sh
. /usr/share/gazebo-11/setup.sh
export TURTLEBOT3_MODEL=waffle
export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:/opt/ros/humble/share/turtlebot3_gazebo/models
eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"
#isaac sim ros2 bridge
export FASTRTPS_DEFAULT_PROFILES_FILE=~/.ros/fastdds.xml

# pnpm
export PNPM_HOME="/home/joe/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
export PATH=/home/joe/.pixi/bin:$PATH
# just
if (( $+commands[just] )); then
  eval "$(just --completions zsh)"
fi

if [ "$PIXI_IN_SHELL" = "1" ]; then
  if [ -n "$(just --summary | grep setup)" ]; then
    . <(just setup)
  fi
fi

alias rc=". $HOME/.zshrc"
