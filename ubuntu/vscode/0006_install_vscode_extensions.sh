#!/bin/bash

# VSCode extension IDs
extensions=(
    # Formatting
    "esbenp.prettier-vscode"
    "foxundermoon.shell-format"

    # Github
    "eamodio.gitlens"
)

for extension in "${extensions[@]}"; do
    code --install-extension "$extension"
done
