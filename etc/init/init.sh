#!/usr/bin/env bash
# Environment bootstrap. Run via `make init` (DOTPATH is exported by the Makefile).
# Idempotent: safe to re-run.

set -e

DOTPATH="${DOTPATH:-$HOME/.dotfiles}"

. "$DOTPATH/etc/init/prompts.sh"

# `make install` では preflight で件数表示済み。単体の `make init` ならここで出す。
[ -n "$DOTFILES_PREFLIGHT_DONE" ] || bash "$DOTPATH/etc/init/preflight.sh" init

# 対話的な入力はここ (冒頭) に集める: sudo パスワードを一度だけ聞き、以降は
# キャッシュを維持して無人で進める (brew bundle 等の長い処理中に止まらないように)。
if needs_sudo; then
    sudo -v
    # sudo のタイムスタンプを定期更新し、このスクリプト終了時に止める。
    while true; do sudo -n true; sleep 50; kill -0 "$$" || exit; done 2>/dev/null &
    _keepalive=$!
    trap 'kill "$_keepalive" 2>/dev/null' EXIT
fi
echo ''
echo "✅ ユーザー確認は全て完了しました。ここからは席を離れて大丈夫です ☕"
echo ''

# Linux/WSL: install zsh first (a login-shell candidate) before Homebrew.
if [ "$(uname)" = "Linux" ] && ! command -v zsh >/dev/null 2>&1; then
    echo "installing zsh..."
    sudo apt update && sudo apt install -y zsh
fi

# Make zsh the login shell (Linux/WSL default is bash, so the zsh config —
# including the prompt — would never load in a new terminal). macOS already
# defaults to zsh. sudo 認証は冒頭で済ませているので、ここでは聞かれない。
# 失敗しても install 全体は止めない。
if [ "$(uname)" = "Linux" ] && command -v zsh >/dev/null 2>&1; then
    _zsh="$(command -v zsh)"
    if [ "$(getent passwd "$(id -un)" | cut -d: -f7)" != "$_zsh" ]; then
        echo "changing login shell to $_zsh..."
        grep -qx "$_zsh" /etc/shells || echo "$_zsh" | sudo tee -a /etc/shells >/dev/null
        sudo chsh -s "$_zsh" "$(id -un)" || echo "chsh failed; run manually: chsh -s $_zsh" >&2
    fi
    unset _zsh
fi

# Homebrew — the official installer covers both macOS and Linux, so a single
# path works everywhere and the same Brewfile applies. NONINTERACTIVE で
# "Press RETURN" の確認を省く (sudo は冒頭で認証済み)。
if ! has_brew; then
    echo "installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
