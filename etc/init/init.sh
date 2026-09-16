#!/usr/bin/env bash
# Environment bootstrap. Run via `make init` (DOTPATH is exported by the Makefile).
# Idempotent: safe to re-run.

set -e

DOTPATH="${DOTPATH:-$HOME/.dotfiles}"

# Linux/WSL: install zsh first (a login-shell candidate) before Homebrew.
if [ "$(uname)" = "Linux" ] && ! command -v zsh >/dev/null 2>&1; then
    echo "installing zsh..."
    sudo apt update && sudo apt install -y zsh
fi

# Homebrew — the official installer covers both macOS and Linux, so a single
# path works everywhere and the same Brewfile applies.
if ! command -v brew >/dev/null 2>&1; then
    echo "installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# A fresh install isn't on PATH yet; load brew's env from the known prefixes so
# `brew bundle` below works on the first run (.zshrc does this for interactive
# shells). Covers Apple Silicon, Intel mac, and Linuxbrew.
if ! command -v brew >/dev/null 2>&1; then
    for _brew in /opt/homebrew/bin/brew /usr/local/bin/brew \
                 /home/linuxbrew/.linuxbrew/bin/brew "$HOME/.linuxbrew/bin/brew"; do
        [ -x "$_brew" ] && eval "$("$_brew" shellenv)" && break
    done
    unset _brew
fi

if command -v brew >/dev/null 2>&1; then
    echo "installing packages from Brewfile..."
    brew bundle --file="$DOTPATH/Brewfile"
fi

# neovim on Linux: AppImage is the simplest, most reliable route (macOS gets
# neovim from the Brewfile).
if [ "$(uname)" = "Linux" ] && ! command -v nvim >/dev/null 2>&1; then
    echo "installing neovim..."
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
    chmod u+x nvim.appimage
    mkdir -p ~/opt/bin
    mv nvim.appimage ~/opt/bin/nvim
fi

mkdir -p ~/.config

# 言語ランタイム (Node / Python) と uv は Brewfile で導入する。
# バージョン固定が要る場合は uv (Python) / プロジェクト単位のツールで管理する。

# tmux plugin manager
[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Nerd font (macOS) comes from the Brewfile cask (font-hackgen-nerd).

echo "init done."
