#!/bin/bash

echo -e "\e[33m [0002] Defining bash aliases... \e[0m"

# Define aliases here
cat <<'EOF' >>~/.bash_aliases
alias l='ls -la --color=auto'
alias grep='grep --color=auto'
EOF

echo -e "\e[33m Sourcing bash aliases in ~/.bashrc... \e[0m"

if ! grep -q "if \[ -f ~/.bash_aliases \]; then" ~/.bashrc; then
  cat <<'EOF' >>~/.bashrc

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
EOF
fi

echo -e "\e[33m Successfully sourced bash aliases in ~/.bashrc. \e[0m"

echo -e "\e[33m [0002] Successfully defined bash aliases. \e[0m"
