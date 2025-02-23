#!/bin/bash

# Define bash aliases
cat <<'EOF' >>~/.bash_aliases
alias l='ls -la --color=auto'
EOF

# Ensure .bash_aliases is sourced in .bashrc
if ! grep -q "if \[ -f ~/.bash_aliases \]; then" ~/.bashrc; then
  cat <<'EOF' >>~/.bashrc

# Source custom aliases if available
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOF
fi
