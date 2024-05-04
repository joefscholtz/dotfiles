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

export FPATH="$HOME/.config/zsh/eza/completions/zsh:$FPATH"

# bun completions
[ -s "/home/joe/.bun/_bun" ] && source "/home/joe/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

#aliases
alias nv="nvim"
export BAT_THEME=Dracula
alias cat="bat"
alias cd_old="cd"
alias man_old="man"
alias man="batman"

#zypper
alias zin='sudo zypper in'
alias zinr='sudo zypper inr'
alias zrm='sudo zypper rm'
alias zsi='sudo zypper si'
alias zse='sudo zypper se'
alias zve='sudo zypper ve'
alias zdup='sudo zypper dup'

alias l='eza --all --color=always --git --icons=always'
alias ll='eza --all --long --color=always --git --icons=always --group'

#starship
eval "$(starship init zsh)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --zsh)"
# . /usr/share/fzf/shell/key-bindings.zsh
# . /usr/share/fzf/shell/completion.zsh

# -- Use fd instead of fzf --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

#zoxide
eval "$(zoxide init zsh)"
alias cd="z"
