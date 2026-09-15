# dotfiles
for macOS / WSL / native Linux (Ubuntu).

## Setup
```sh
$ curl -sSL https://raw.githubusercontent.com/shohei1029/dotfiles/main/install.sh | sh
```

または手動で:
```sh
$ git clone https://github.com/shohei1029/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ make install   # = update + deploy + init
```

### Make targets

| target | 説明 |
| --- | --- |
| `make deploy` | dotfilesを`$HOME`にシンボリックリンク (`.zshrc`/`.bashrc`はスタブ生成) |
| `make brew` | `Brewfile`のパッケージを導入 (brew導入済みの環境向け) |
| `make init` | 環境セットアップ (Homebrew導入 + brew bundle + anyenv/tmux) |
| `make install` | update→deploy→initを一括実行 |
| `make min_deploy` | `min_sets/`の軽量設定のみ配置 (サーバ等向け) |
| `make help` | 全ターゲット一覧 |

### シェル構成 (OS別自動読み込み)

`.zshrc`が共通設定で、起動時にOSを判定して対応するファイルを自動sourceする。

| OS | 判定 | 読み込まれるファイル |
| --- | --- | --- |
| macOS | `uname -s` = Darwin | `.zshrc.mac` |
| WSL | `/proc/version`に`microsoft`/`wsl` | `.zshrc.wsl` |
| native Linux | それ以外のLinux | `.zshrc.linux` |

最後に`~/.zshrc.local`（git管理外のマシン固有設定）があれば読み込む。bashも
同様に`~/.bashrc.local`を読み込む。

> **スタブ方式**: `.zshrc`/`.bashrc`はシンボリックリンクではなく、`$HOME`上に
> repo設定を`source`するだけの小さな実ファイル（スタブ）として配置される。
> ツールが`~/.zshrc`等へ自動追記（`>>`）してもリンク越しにrepoが汚れず、追記は
> スタブ側に残る。マシン固有の設定は`~/.zshrc.local` / `~/.bashrc.local`へ。

### Secrets (.env)

APIキー等は`.env`に置く（**git管理外**）。テンプレートをコピーして利用:
```sh
$ cp .env.example .env   # 値を埋める
```

## Misc.

### iTerm2
`git clone https://github.com/rickhanlonii/Solarized-Darcula/`

### フォント
`font-hackgen-nerd`（Nerd Font）は`Brewfile`のcaskで導入される（macOSのみ）。
Nerd FontにはPowerlineの記号も含まれる。iTerm2設定で`HackGen Console NF`を指定。

GitHubのmonaspace系もよさそう

### zsh
- Shellのデフォルトに設定  
`$ chsh -s /bin/zsh`
- Updating  
`make update`

#### プラグイン管理 (antidote)

プラグインは [antidote](https://antidote.sh/) で管理している（旧 zplug から移行）。

```sh
brew install antidote
```

- プラグイン一覧: `.zsh_plugins.txt`
- 初回シェル起動時に自動でプラグインを clone し、`.zsh_plugins.zsh`（静的バンドル）を生成する
- prezto のモジュールは `getantidote/use-prezto` ブリッジ経由でロード。プロンプトは prezto の `seraph` テーマ（`shohei1029/xiang` 提供）

## References
- [優れた dotfiles を設計して、最速で環境構築する話](https://qiita.com/b4b4r07/items/24872cdcbec964ce2178)
- [PiroPiro](https://github.com/PiroHiroPiro/dotfiles)
