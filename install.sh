#!/bin/sh
# dotfiles bootstrap — one-shot setup for a fresh machine.
#
#   curl -sSL https://raw.githubusercontent.com/shohei1029/dotfiles/main/install.sh | sh
#
# Idempotent: safe to re-run. Uses HTTPS (no SSH key / GitHub login needed).
set -e

DOTPATH="${DOTPATH:-$HOME/.dotfiles}"
REPO_URL="https://github.com/shohei1029/dotfiles.git"
TARBALL_URL="https://github.com/shohei1029/dotfiles/archive/refs/heads/main.tar.gz"

# --- fetch the repo --------------------------------------------------------
if [ -d "$DOTPATH/.git" ]; then
    echo "==> $DOTPATH already exists; pulling latest."
    git -C "$DOTPATH" pull --ff-only
elif command -v git >/dev/null 2>&1; then
    echo "==> Cloning via git."
    git clone --recursive "$REPO_URL" "$DOTPATH"
elif command -v curl >/dev/null 2>&1 || command -v wget >/dev/null 2>&1; then
    echo "==> git not found; downloading tarball."
    if command -v curl >/dev/null 2>&1; then
        curl -sSL "$TARBALL_URL" | tar xzv
    else
        wget -O - "$TARBALL_URL" | tar xzv
    fi
    # tarball extracts to dotfiles-main/
    mv -f dotfiles-main "$DOTPATH"
else
    echo "git, curl, or wget is required." >&2
    exit 1
fi

cd "$DOTPATH" || { echo "not found: $DOTPATH" >&2; exit 1; }

# --- ensure make is available ----------------------------------------------
if ! command -v make >/dev/null 2>&1; then
    echo "==> make not found; installing build tools."
    if [ "$(uname)" = "Darwin" ]; then
        xcode-select --install
        echo "Re-run this script after the Xcode Command Line Tools finish installing." >&2
        exit 1
    elif [ "$(uname)" = "Linux" ]; then
        sudo apt update && sudo apt install -y build-essential
    fi
fi

# --- deploy + init env -----------------------------------------------------
# Run targets directly (skip `make update`, which would `git pull` a repo we
# may have just cloned/downloaded). `init` installs Homebrew and runs
# `brew bundle` itself, so `make brew` is not needed (and would fail here
# since brew isn't installed yet on a fresh machine).
make deploy init

echo "==> Done. Restart your shell or run: exec \$SHELL"
