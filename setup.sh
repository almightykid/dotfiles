#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

clone_if_missing() {
    local repo="$1" dest="$2"
    if [ ! -d "$dest" ]; then
        echo "Cloning $repo..."
        git clone --depth=1 "$repo" "$dest"
    fi
}

# Homebrew
if ! command -v brew >/dev/null 2>&1; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

echo "Installing Homebrew bundle..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# zsh community plugins (not available via brew)
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

# tmux plugin manager
clone_if_missing https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"

# Stow: zshrc goes to $HOME, everything else follows .stowrc's ~/.config target
echo "Stowing dotfiles..."
cd "$DOTFILES_DIR"
stow -t "$HOME" zshrc
stow tmux starship ghostty

echo "Done. Restart your shell, and inside tmux press prefix + I to install tmux plugins."
