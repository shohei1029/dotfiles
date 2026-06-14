# dotfiles
for macOS or Ubuntu

## Setup
```sh
$ curl -sSL https://raw.githubusercontent.com/shohei1029/dotfiles/master/install.sh | sh
```

## Misc.

### iTerm2
`git clone https://github.com/rickhanlonii/Solarized-Darcula/`

### powerline対応のフォント (Ricty)利用準備
Nerd Font対応フォントであればPowerlineで利用する記号も含まれている
```sh
brew install font-hackgen-nerd
```
iTerm3設定で`HackGen Console NF`を指定

GitHubのmonaspace系もよさそう

### zsh
- Shellのデフォルトに設定  
`$ chsh -s /bin/zsh`
- Updating  
`git pull && git submodule update --init --recursive`

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
