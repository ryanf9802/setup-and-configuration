#!/bin/bash
# This script removes all alias definitions from ~/.bash_aliases
# and deletes the block in ~/.bashrc that sources the alias file.
# After running this script, please restart your terminal or run "source ~/.bashrc" for changes to take effect.

# Remove all alias definitions from ~/.bash_aliases
if [ -f ~/.bash_aliases ]; then
  # Delete all lines that start with "alias "
  sed -i '/^alias /d' ~/.bash_aliases
  echo "Removed all alias definitions from ~/.bash_aliases."
else
  echo "~/.bash_aliases not found. Skipping alias removal."
fi

# Remove the sourcing block from ~/.bashrc
if [ -f ~/.bashrc ]; then
  sed -i '/# Source custom aliases if available/,+3d' ~/.bashrc
  echo "Removed the alias sourcing block from ~/.bashrc."
else
  echo "~/.bashrc not found. Skipping sourcing block removal."
fi

echo "Undo operations completed. Please restart your terminal or run 'source ~/.bashrc' to apply the changes."
