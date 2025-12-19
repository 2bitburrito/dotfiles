#!/bin/bash
set -euo pipefail

# Dump Brewfile (without comments to avoid noise) to your dotfiles
brew bundle dump --file="$HOME/.local/share/chezmoi/private_dot_Brewfile" --force --no-comments
