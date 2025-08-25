# Zsh configuration file
# 
# see:
# - https://qiita.com/ryutoyasugi/items/cb895814d4149ca44f12

# =============================================================================
# Aliases
# =============================================================================

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS
  alias ls="ls -vFG"
  alias la="ls -vaFG"
  alias ll="ls -lFG"
else
  # Linux
  alias ls="ls -vXF --color=auto"
  alias la="ls -avXF --color=auto"
  alias ll="ls -lXF --color=auto"
fi

# history search
alias hisg="history | grep"

# Quick reload
alias soz="source ~/.zshrc"

alias cc="claude --dangerously-skip-permissions"

# =============================================================================
# Completion settings
# =============================================================================

# Enable completion system
autoload -Uz compinit; compinit

# Completion styling
zstyle ':completion:*:default' menu select=1

# Directory navigation
setopt auto_pushd              # Automatically push directories to stack
setopt pushd_ignore_dups       # Don't duplicate directories in stack

# Error handling
setopt correct                 # Spell correction for commands
setopt no_beep                 # Disable beep sounds
setopt nolistbeep             # No beep on completion list

# Completion behavior
setopt list_packed            # Compact display when many completions
setopt magic_equal_subst      # Enable completion after = in arguments
setopt interactive_comments   # Enable comments in interactive shell

# =============================================================================
# environment variables
# =============================================================================

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad

# =============================================================================
# Prompt settings
# =============================================================================

# 色設定
autoload -Uz colors && colors

# gitブランチ表示用にvcs_infoを使用
autoload -Uz vcs_info
precmd() { vcs_info }

# vcs_info設定
zstyle ':vcs_info:git:*' formats '(%b)'
zstyle ':vcs_info:*' enable git

setopt PROMPT_SUBST

# bash風プロンプト: ユーザー名 ➜ パス (ブランチ名) $
PROMPT='%B%F{green}%n%f %F{blue}➜%f %F{cyan}%~%f %F{yellow}${vcs_info_msg_0_}%f %# %b'

export PATH="$HOME/my-tools:$PATH"
