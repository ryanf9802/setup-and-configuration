#!/bin/bash
# This script configures your terminal prompt with colors and Git repository status.
# It writes the configuration to ~/.bash_prompt and ensures that .bashrc sources it.
# After running this script, please restart your terminal or run "source ~/.bashrc" for changes to take effect.

# Define the prompt configuration file
PROMPT_FILE=~/.bash_terminal

# Write the terminal prompt configuration to PROMPT_FILE
cat << 'EOF' > "$PROMPT_FILE"
# Terminal prompt configuration with colors and Git repository info

# Define ANSI color codes
RED='\[\e[0;31m\]'
GREEN='\[\e[0;32m\]'
YELLOW='\[\e[0;33m\]'
BLUE='\[\e[0;34m\]'
PURPLE='\[\e[0;35m\]'
CYAN='\[\e[0;36m\]'
WHITE='\[\e[0;37m\]'
NC='\[\e[0m\]'  # No Color

# Function to display Git repository information:
# - Shows the current branch
# - Displays the number of commits ahead of the upstream branch (if available)
git_info() {
  if git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if git rev-parse --abbrev-ref @{u} > /dev/null 2>&1; then
      ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)
    else
      ahead=0
    fi
    echo -e "${PURPLE}[${branch}|${ahead}]${NC}"
  fi
}

# Set the prompt:
# It displays username@hostname (green), working directory (blue),
# and Git info (purple) if applicable.
export PS1="${GREEN}\u@\h${NC}:${BLUE}\w${NC} \$(git_info) \$ "
EOF

echo "Terminal prompt configuration written to $PROMPT_FILE."

# Ensure that the prompt configuration is sourced in .bashrc
if ! grep -q "source ~/.bash_prompt" ~/.bashrc; then
  cat << 'EOF' >> ~/.bashrc

# Source custom terminal prompt configuration if available
if [ -f ~/.bash_prompt ]; then
    source ~/.bash_prompt
fi
EOF
  echo "Added terminal prompt sourcing block to ~/.bashrc."
else
  echo "Terminal prompt sourcing already configured in ~/.bashrc."
fi
