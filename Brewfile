# Brewfile — packages required by this dotfiles setup.
# Install with: brew bundle --file=~/.dotfiles/Brewfile
#
# 依存で勝手に入るものは記載せず、明示的にインストールするメインのものだけを列挙する
# (= `brew leaves` 相当)。

## Shell ---------------------------------------------------------------------
# zsh plugin manager (see .zsh_plugins.txt)
brew "antidote"

# Fuzzy finder — ^r history search, fh / fkill helpers, emoji-cli filter (.zshrc)
brew "fzf"
# Faster `cd` (replaces enhancd); .zshrc wires it to the `cd` command
brew "zoxide"

## Editor --------------------------------------------------------------------
# .zshrc は nvim があれば EDITOR=nvim にする
brew "neovim"

## Dev tools -----------------------------------------------------------------
brew "gh"              # GitHub CLI
brew "git-filter-repo" # git 履歴の書き換え
brew "node"            # Node.js
brew "python"          # システム用の最新 Python (固定したい時は uv 側で管理)
brew "uv"              # Python パッケージ / プロジェクト・バージョン管理

## Modern CLI ---------------------------------------------------------------
# 高速な検索/表示ツール群 (grep/find/cat/sed の後継)。
brew "ripgrep" # rg: 高速 grep
brew "fd"      # find の後継
brew "bat"     # cat の後継 (シンタックスハイライト)
brew "eza"     # ls の後継
brew "sd"      # sed の後継 (find & replace)
brew "jq"      # JSON クエリ/変換

## Misc / CLI ----------------------------------------------------------------
brew "btop"  # リソースモニタ
brew "cowsay"
brew "sl"    # `emacs` alias のお遊び

## Casks ---------------------------------------------------------------------
# cask は macOS 専用 (Linuxbrew には無い) ので mac 判定で囲む。
if OS.mac?
  cask "clipy"             # クリップボード履歴
  cask "font-hackgen-nerd" # 端末フォント (Nerd Font)
end
