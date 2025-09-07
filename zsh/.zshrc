# https://docs.brew.sh/Installation#post-installation-steps
eval "$(/opt/homebrew/bin/brew shellenv)"
export BREW_DIR="$(brew --prefix)"
export HOMEBREW_BUNDLE_FILE="$HOME/Brewfile"
export HOMEBREW_NO_ANALYTICS=1

# https://zsh.sourceforge.io/Doc/Release/Options.html
autoload -Uz compinit; compinit
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

# https://mise.jdx.dev/installing-mise.html#zsh
eval "$(mise activate zsh)"

# Scripts.
export PATH="$PATH:$HOME/.local/bin"

if [[ -a "$HOME/.zshrc_custom" ]]; then
  source "$HOME/.zshrc_custom"
fi
