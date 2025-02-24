#!/bin/bash

# VSCode extension IDs
extensions=(
    # Formatting
    "esbenp.prettier-vscode"
    "foxundermoon.shell-format"
    "ms-python.black-formatter"

    # Github
    "eamodio.gitlens"

    # Languages
    "ms-python.python"
    "ms-python.vscode-pylance"

)

for extension in "${extensions[@]}"; do
    code --install-extension "$extension"
done
