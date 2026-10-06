#!/usr/bin/env bash
# これから発生するユーザー確認 (y/n・パスワード) の件数を最初に表示する。
# 全部終わると init.sh が ✅ を表示するので、それが出たら席を離れてよい。
#   usage: preflight.sh <phase>...   (phase: deploy | init)

DOTPATH="${DOTPATH:-$HOME/.dotfiles}"
. "$DOTPATH/etc/init/prompts.sh"

items=()
for phase in "$@"; do
    case "$phase" in
        deploy) needs_nvim_prompt && items+=("~/.config/nvim を上書きするか (y/n)") ;;
        init)   needs_sudo && ! sudo -n true 2>/dev/null && items+=("sudo パスワード") ;;
    esac
done

echo ''
if [ ${#items[@]} -eq 0 ]; then
    echo "✅ ユーザー確認はありません。席を離れて大丈夫です ☕"
else
    echo "🙋 これから ${#items[@]} 件の確認があります (全部終わったら ✅ を表示します):"
    for i in "${!items[@]}"; do
        echo "   $((i + 1)). ${items[$i]}"
    done
fi
echo ''
