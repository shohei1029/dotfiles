#!/usr/bin/env bash
# Environment bootstrap. Run via `make init` (DOTPATH is exported by the Makefile).
# Idempotent: safe to re-run.

set -e

DOTPATH="${DOTPATH:-$HOME/.dotfiles}"

if [ "$(uname)" = "Darwin" ]; then
    # --- macOS ---
    if ! command -v brew >/dev/null 2>&1; then
        echo "installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    echo "installing packages from Brewfile..."
    brew bundle --file="$DOTPATH/Brewfile"

elif [ "$(uname)" = "Linux" ]; then
    # --- Linux / WSL ---
    if ! command -v zsh >/dev/null 2>&1; then
        echo "installing zsh..."
        sudo apt update && sudo apt install -y zsh
    fi

    # Linuxbrew (so the same Brewfile works as on macOS).
    if ! command -v brew >/dev/null 2>&1; then
        echo "installing Linuxbrew..."
        bash "$DOTPATH/etc/init/install_linuxbrew.sh"
    fi

    if command -v brew >/dev/null 2>&1; then
        echo "installing packages from Brewfile..."
        brew bundle --file="$DOTPATH/Brewfile"
    fi

    # neovim: AppImage is the simplest, most reliable route on Linux.
    if ! command -v nvim >/dev/null 2>&1; then
        echo "installing neovim..."
        curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
        chmod u+x nvim.appimage
        mkdir -p ~/opt/bin
        mv nvim.appimage ~/opt/bin/nvim
    fi
fi

mkdir -p ~/.config

# anyenv — manages pyenv/nodenv/etc.
if ! command -v anyenv >/dev/null 2>&1 && [ ! -d "$HOME/.anyenv" ]; then
    echo "installing anyenv..."
    git clone https://github.com/anyenv/anyenv ~/.anyenv
    export PATH="$HOME/.anyenv/bin:$PATH"
    anyenv install --force-init
    mkdir -p "$(anyenv root)/plugins"
    git clone https://github.com/znz/anyenv-update.git "$(anyenv root)/plugins/anyenv-update"
fi

# tmux plugin manager
[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Powerline / Nerd fonts
if [ -f "$DOTPATH/etc/init/font-installer.sh" ]; then
    zsh "$DOTPATH/etc/init/font-installer.sh"
fi

echo "init done."
