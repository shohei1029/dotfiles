-- エディタの基本オプション（旧 init.vim の set 群を移植）
-- leader キー（LSP 等のキーマップで使用）。プラグイン読込前に設定する
vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.expandtab = true      -- タブ入力を複数の空白入力に置き換える
opt.tabstop = 4           -- 画面上でタブ文字が占める幅
opt.shiftwidth = 4        -- 自動インデントでずれる幅
opt.softtabstop = 4       -- 連続した空白に対してタブ/BSでカーソルが動く幅
opt.autoindent = true     -- 改行時に前の行のインデントを継続する
opt.smartindent = true    -- 改行時に入力された行の末尾に合わせてインデントを増減する

opt.number = true         -- 行番号を表示
opt.showmode = true
opt.title = true
opt.showmatch = true      -- 閉じ括弧入力時に対応する括弧を強調

opt.clipboard = "unnamed" -- OS のクリップボードと連携

opt.ignorecase = true     -- 検索時に大文字小文字を区別しない
opt.smartcase = true      -- ただし大文字が含まれる場合は区別する
opt.wrapscan = true       -- 検索がファイル末尾に達したら先頭に戻る
opt.incsearch = true      -- インクリメンタルサーチ
opt.hlsearch = true       -- 検索文字の強調表示
opt.scrolloff = 8         -- 上下スクロール時の視界を確保

opt.termguicolors = true  -- 24bit カラーを有効化
opt.background = "dark"
opt.signcolumn = "yes"    -- サインカラム（診断表示）を常に表示

-- Python プロバイダは指定しない（PATH 上の python3 を自動検出させる）
