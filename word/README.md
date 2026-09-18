# Word for Mac の設定管理

Microsoft Word for Mac の設定（**キーバインド／ショートカット**・スタイル・
マクロ・定型句など）をこの dotfiles で管理し、別マシンへ移植できるようにする。

macOS 専用。

## なぜ symlink 方式ではないのか

このリポジトリの他の設定は `$HOME` への symlink で配るが、Word は例外:

- **plist** (`com.microsoft.Word`) は `cfprefsd` がメモリにキャッシュするため、
  symlink 先を書き換えても反映されず、Word 終了時にキャッシュで上書きされる。
- **Normal.dotm** は Word が起動中に頻繁に書き換え・再生成するため、symlink だと
  リンクごと壊れ、リポジトリも汚れる。

そのため「必要なときだけ手動で取り込む／書き戻す」**エクスポート／インポート方式**
にしている。`make deploy` では一切触らない。

## 管理対象

| ファイル | 内容 |
| --- | --- |
| `Normal.dotm` | **キーバインド（ショートカット）**・スタイル・マクロ・定型句の本体 |
| `com.microsoft.Word.plist` | 移植価値のある設定キーのみ（allowlist 抽出） |

Word for Mac には Windows 版のような独立したキーバインドファイル（`.kbd`）は
なく、**ショートカットのカスタマイズは `Normal.dotm` に保存される**。これを
持ち運べば別マシンでも同じショートカットが使える。

plist はウィンドウ位置・最近開いたファイル・セッション情報などマシン固有の値が
大半のため、`bin/word-settings` の `PLIST_KEYS` に列挙したキーだけを対象にする。

## 使い方

`bin/` は PATH に載っているので、どこからでも `word-settings` で実行できる。

```sh
# 現在のマシンの Word 設定をリポジトリに取り込む（→ git commit）
word-settings export

# リポジトリの設定を（別の）マシンに書き戻す
word-settings import

# 差分確認
word-settings diff
```

**Word は終了してから**実行すること（起動中だと終了時に上書きされる）。
`import` は既存の `Normal.dotm` を `Normal.dotm.bak.<日時>` に退避してから上書きする。

## 移植手順（別マシン）

1. dotfiles を clone / `make deploy`（`word-settings` が PATH に入る）
2. Word をインストールして一度起動→終了
3. `word-settings import`
4. Word を起動し、ショートカットが反映されているか確認
