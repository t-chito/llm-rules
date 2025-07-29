# Bash configuration file
#

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
alias soz="source ~/.bashrc"

alias cc="claude --dangerously-skip-permissions"

# =============================================================================
# Completion settings
# =============================================================================

# Enable programmable completion features (you don't need to enable this,
# if it's already enabled in /etc/bash.bashrc and /etc/profile sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# =============================================================================
# Directory navigation
# =============================================================================

# Automatically push directories to stack (bash: use 'pushd' and 'popd')
# No direct equivalent for auto_pushd, but can define cd as pushd:
# Uncomment the following line if you want 'cd' to behave like 'pushd'
# cd() { builtin pushd "$@" > /dev/null; }

# Don't duplicate directories in stack (no direct bash equivalent)

# =============================================================================
# Error handling
# =============================================================================

# Spell correction for commands (bash: 'shopt -s cdspell' for directory names)
shopt -s cdspell

# Disable beep sounds
setterm -blength 0 2>/dev/null

# =============================================================================
# Completion behavior
# =============================================================================

# Compact display when many completions (bash: no direct equivalent)
# Enable completion after = in arguments (bash: default behavior)
# Enable comments in interactive shell
shopt -s interactive_comments

# =============================================================================
# environment variables
# =============================================================================

export LANG=ja_JP.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad
