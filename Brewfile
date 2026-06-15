# Brewfile — packages required by this dotfiles setup.
# Install with: brew bundle --file=~/.dotfiles/Brewfile
#
# 依存で勝手に入るものは記載せず、明示的にインストールするメインのものだけを列挙する
# (= `brew leaves` 相当)。

## Shell ---------------------------------------------------------------------
# zsh plugin manager (see .zsh_plugins.txt)
brew "antidote"

# Fuzzy finders used by .zshrc:
#   - fzf:  enhancd / emoji-cli filter, fh / fkill helpers
#   - peco: ^r history search (peco-select-history)
brew "fzf"
brew "peco"

## Editor --------------------------------------------------------------------
# .zshrc は nvim があれば EDITOR=nvim にする
brew "neovim"

## Dev tools -----------------------------------------------------------------
brew "gh"              # GitHub CLI
brew "git-filter-repo" # git 履歴の書き換え
brew "node"            # Node.js
brew "python"          # システム用の最新 Python (固定したい時は uv 側で管理)
brew "uv"              # Python パッケージ / プロジェクト・バージョン管理

## Misc / CLI ----------------------------------------------------------------
brew "btop"  # リソースモニタ
brew "cowsay"
brew "sl"    # `emacs` alias のお遊び

## Casks ---------------------------------------------------------------------
cask "clipy"             # クリップボード履歴
cask "font-hackgen-nerd" # 端末フォント (Nerd Font)
