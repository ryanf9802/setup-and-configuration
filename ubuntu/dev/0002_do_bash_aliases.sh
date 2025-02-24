#!/bin/bash

# Define aliases here
cat <<'EOF' >>~/.bash_aliases
alias l='ls -la --color=auto'
alias grep='grep --color=auto'
EOF

if ! grep -q "if \[ -f ~/.bash_aliases \]; then" ~/.bashrc; then
  cat <<'EOF' >>~/.bashrc

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOF
fi
