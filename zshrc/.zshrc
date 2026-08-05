# ------------------------------------------------------------------------------
# Oh My Zsh
# ------------------------------------------------------------------------------

export ZSH="$HOME/.oh-my-zsh"
ENABLE_CORRECTION="true"

# ------------------------------------------------------------------------------
# Environment
# ------------------------------------------------------------------------------

export EDITOR="code"
export VISUAL="code"
export PAGER="less"
export LESS="-R"

# ------------------------------------------------------------------------------
# History
# ------------------------------------------------------------------------------

HISTFILE="$HOME/.zsh_history"
HISTSIZE=100000
SAVEHIST=100000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_VERIFY

# ------------------------------------------------------------------------------
# Completion
# ------------------------------------------------------------------------------

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# ------------------------------------------------------------------------------
# Plugins
# ------------------------------------------------------------------------------

plugins=(
  # Git
  git

  # Containers & Kubernetes
  docker
  docker-compose
  kubectl
  helm
  terraform

  # Languages
  python
  pip
  golang

  # Utilities
  history
  command-not-found
  vscode

  # UI
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# ------------------------------------------------------------------------------
# Plugin Configuration
# ------------------------------------------------------------------------------

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#9A3412"

# ------------------------------------------------------------------------------
# Load Oh My Zsh
# ------------------------------------------------------------------------------

source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------------------------
# Prompt
# ------------------------------------------------------------------------------

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source <(fzf --zsh)