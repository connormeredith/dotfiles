export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="spaceship"

# https://spaceship-prompt.sh/options/
SPACESHIP_PROMPT_ORDER=(
  dir
  git
  line_sep
  exit_code
  char
)

plugins=(git nvm)

# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/nvm
zstyle ':omz:plugins:nvm' autoload true
NVM_HOMEBREW=/opt/homebrew/opt/nvm/

# Brew paths and auto-complete.
eval "$(/opt/homebrew/bin/brew shellenv)"
export LIBRARY_PATH="$LIBRARY_PATH:/opt/homebrew/lib"
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh

export EDITOR="nvim"

unsetopt share_history

alias reset="clear && printf '\e[3J'"

# Disable node repl history.
export NODE_REPL_HISTORY=""

# Keybindings.
bindkey "^p" up-line-or-beginning-search
bindkey "^n" down-line-or-beginning-search

# Python modules
export PATH="$PATH:$HOME/Library/Python/3.9/bin"

# Scripts.
export PATH="$PATH:$HOME/.local/bin"
