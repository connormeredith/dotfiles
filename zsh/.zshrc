# https://zsh.sourceforge.io/Doc/Release/Options.html
autoload -U compinit; compinit
zstyle ':completion:*:*:*:*:*' menu select

setopt autocd
unsetopt share_history

# Set emacs key bindings.
bindkey -e

# ^p or up arrow to fuzzy search history forward.
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search
bindkey "^p" up-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search

# ^n or down arrow to fuzzy search history backward.
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^n" down-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# shift + tab to reverse menu search.
bindkey "^[[Z" reverse-menu-complete

# https://docs.brew.sh/Installation#post-installation-steps
eval "$(/opt/homebrew/bin/brew shellenv)"
export BREW_DIR="$(brew --prefix)"
export HOMEBREW_BUNDLE_FILE="$HOME/Brewfile"
export HOMEBREW_NO_ANALYTICS=1

# https://spaceship-prompt.sh
SPACESHIP_PROMPT_ORDER=(
  dir
  git
  line_sep
  exit_code
  char
)
source "$BREW_DIR/opt/spaceship/spaceship.zsh"

# https://junegunn.github.io/fzf/shell-integration/#shell-integration
source <(fzf --zsh)

export EDITOR="nvim"

alias reset="clear && printf '\e[3J'"

# Scripts.
export PATH="$PATH:$HOME/.local/bin"

lazy_load_nvm() {
  unset -f nvm
  unset -f node
  unset -f npm

  export NVM_DIR=~/.nvm
  [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
}

nvm() {
  lazy_load_nvm
  nvm $@
}

node() {
  lazy_load_nvm
  node $@
}

npm() {
  lazy_load_nvm
  npm $@
}

autoload -U add-zsh-hook

load-nvmrc() {
  if [ -f "$(pwd)/.nvmrc" ]; then
      nvm use
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

[ -s "$BREW_DIR/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$BREW_DIR/opt/nvm/etc/bash_completion.d/nvm"

if [[ -a "$HOME/.zshrc_custom" ]]; then
  source "$HOME/.zshrc_custom"
fi
