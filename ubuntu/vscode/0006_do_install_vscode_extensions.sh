#!/bin/bash

echo -e "\e[33m [0006] Installing VSCode extensions... \e[0m"

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

echo -e "\e[33m [0006] Successfully installed VSCode extensions. \e[0m"
