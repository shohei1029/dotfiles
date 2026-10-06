# Shared conditions for the interactive prompts during setup (sourced, POSIX sh).
# preflight.sh counts them up front and Makefile deploy / init.sh actually ask,
# so both read the same checks here — keep them in one place.

# brew が PATH 上に無くても既知の prefix にあれば「インストール済み」とみなす。
has_brew() {
    command -v brew >/dev/null 2>&1 && return 0
    for _b in /opt/homebrew/bin/brew /usr/local/bin/brew \
              /home/linuxbrew/.linuxbrew/bin/brew "$HOME/.linuxbrew/bin/brew"; do
        [ -x "$_b" ] && return 0
    done
    return 1
}

# deploy: ~/.config/nvim が既にあり、このリポジトリへの symlink でない時だけ上書き確認する。
needs_nvim_prompt() {
    [ -e "$HOME/.config/nvim" ] && [ "$(readlink "$HOME/.config/nvim")" != "$DOTPATH/.config/nvim" ]
}

# init: sudo が要るステップ (zsh の apt install / chsh / Homebrew installer) があるか。
needs_sudo() {
    if [ "$(uname)" = "Linux" ]; then
        command -v zsh >/dev/null 2>&1 || return 0
        [ "$(getent passwd "$(id -un)" | cut -d: -f7)" != "$(command -v zsh)" ] && return 0
    fi
    ! has_brew
}
