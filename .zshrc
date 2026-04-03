# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=/usr/sbin:$HOME/.cargo/bin:$HOME/bin:/usr/local/bin:$HOME/depot_tools:$HOME/.local/bin:$PATH

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
alias nv="nvim"
if command -v batcat >/dev/null 2>&1; then
    alias bat='batcat'
fi
export BAT_THEME=Dracula
alias cat="bat"
alias cd_old="cd"
alias man_old="man"
alias man="batman"
alias rc=". ~/.zshrc"

#zypper
alias zin='sudo zypper in'
alias zinr='sudo zypper inr'
alias zrm='sudo zypper rm'
alias zsi='sudo zypper si'
alias zse='sudo zypper se'
alias zve='sudo zypper ve'
alias zdup='sudo zypper dup'

alias ls='eza --all --color=always --git --icons=always'
alias l='eza --all --color=always --git --icons=always'
alias ll='eza --all --long --color=always --git --icons=always --group'
alias df='duf'
tree(){
  eza -T --icons=always "$@"
}
tree-ignore() {
    git ls-tree -r --name-only HEAD \
        | grep -v -F -f <(git submodule --quiet foreach 'echo $sm_path') \
        | eza --git-ignore -T --icons=always "$@"
}
alias tre='tre --all'

export PAGER=bat

#starship
# Check that the function `starship_zle-keymap-select()` is defined.
# xref: https://github.com/starship/starship/issues/3418
type starship_zle-keymap-select >/dev/null || \
  {
    eval "$(starship init zsh)"
  }

# Set up fzf key bindings and fuzzy completion
# eval "$(fzf --zsh)"
if [ -f /usr/share/fzf/shell/key-bindings.zsh ]; then
  . /usr/share/fzf/shell/key-bindings.zsh
# elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
#   . /usr/share/doc/fzf/examples/key-bindings.zsh
fi

if [ -f /usr/share/fzf/shell/key-bindings.zsh ]; then
  . /usr/share/fzf/shell/completion.zsh
# elif [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ]; then
#   . /usr/share/doc/fzf/examples/key-bindings.zsh
fi

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git -I"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git -I"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git -I . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git -I . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

alias rgf="rg --color=always --line-number --no-heading --smart-case '${*:-}' |
  fzf --ansi \
      --color 'hl:-1:underline,hl+:-1:underline:reverse' \
      --delimiter : \
      --preview 'bat --color=always {1} --highlight-line {2}' \
      --preview-window 'up,60%,border-bottom,+{2}+3/3,~3'"
#zoxide
eval "$(zoxide init zsh)"
alias cd="z"

#poetry
fpath+=~/.zfunc
autoload -Uz compinit && compinit

#https://yazi-rs.github.io/docs/quick-start/#shell-wrapper
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#ros
alias ros="distrobox enter ubuntu2404"
ROS_ACTIVE_DISTRO="jazzy"
if [ -f /opt/ros/${ROS_ACTIVE_DISTRO}/setup.zsh ]; then
  . /opt/ros/${ROS_ACTIVE_DISTRO}/setup.zsh
  if [ -f /usr/share/gazebo/setup.sh ]; then
    . /usr/share/gazebo/setup.sh
  fi
  if [ -f /usr/share/gazebo-11/setup.sh ]; then
    . /usr/share/gazebo-11/setup.sh
  fi

  eval "$(register-python-argcomplete ros2)"
  eval "$(register-python-argcomplete colcon)"
  export RCUTILS_COLORIZED_OUTPUT=1
  if [ -f ~/iplow_ws/src/exwayz_navigation/ros2/exwayz/share/exwayz/local_setup.zsh ]; then
    . ~/iplow_ws/src/exwayz_navigation/ros2/exwayz/share/exwayz/local_setup.zsh
  fi

  if [ -f /opt/exwayz/exwayz_navigation/ros2/exwayz/share/exwayz/local_setup.zsh ]; then
    . /opt/exwayz/exwayz_navigation/ros2/exwayz/share/exwayz/local_setup.zsh
  fi

  if [ -f ~/iplow_ws/install/local_setup.zsh ]; then
    . ~/iplow_ws/install/local_setup.zsh
  fi
  if [ -f ~/tracftec/ttec_ws/install/local_setup.zsh ]; then
    . ~/tracftec/ttec_ws/install/local_setup.zsh
  fi
  
fi

export XAUTHORITY=$HOME/.Xauthority

#just
alias j=just
alias ji='just install'
alias jbi='just build-image'
alias jb='just build'
alias jr='just run'
alias jre='just rebuild'
alias jrm='just run'
alias js='just --list'

#git
alias gtree='git log --graph --oneline --all'
alias gs='git status'
alias ghosts='\gs'
alias ga='git add --all'
gc(){
  git commit -m "$@"
}
alias gw="git commit --no-verify -m \"wip\""
alias gp='git push'
export PATH="/home/joe/.pixi/bin:$PATH"

#c++ projects:
export PKG_CONFIG_PATH=/usr/lib64/pkgconfig:/usr/share/pkgconfig:$PKG_CONFIG_PATH

#general
alias open="xdg-open"
alias timestamp="date +\"%Y_%m_%d_%H_%M_%S\""
sanitize_filename() {
  printf "%s" "$1" \
    | iconv -f utf-8 -t ascii//translit 2>/dev/null \
    | tr '[:upper:]' '[:lower:]' \
    | sed -E 's/[^a-z0-9._-]+/_/g; s/^[-_]+|[-_]+$//g'
}
snake(){
  ccase -t snake "$(sanitize_filename "$*")" | tr -d '\n' | wl-copy
}


#tmux
alias t="tmux_tui.sh"

#tailscale
alias remote="tailscale_remote_ssh.sh"

#stirling pdf
alias pdf="stirling_pdf.sh"

#conceptu
export PATH=$HOME/conceptu/conceptu-git/vpn:$PATH
alias vpn="fortivpn.sh"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/joe/.dart-cli-completion/zsh-config.zsh ]] && . /home/joe/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

#lamma.cpp
export PATH=$HOME/llama.cpp/build/bin/:$PATH

#Ollama
export OLLAMA_API_BASE=http://127.0.0.1:11434
#autoapply
export CHROME_PATH=/var/lib/flatpak/exports/bin/com.google.Chrome

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
