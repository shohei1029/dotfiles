set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=4 "画面上でタブ文字が占める幅
set shiftwidth=4 "自動インデントでずれる幅
set softtabstop=4 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
set noswapfile
set number
set showmode
set title
set showmatch " 閉じ括弧入力時に対応する括弧の強調
syntax on
imap jj <esc>

if has('nvim')
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

"Python3 support
let g:python3_host_prog = expand('$HOME') . '/.pyenv/shims/python'


" dein settings {{{
if &compatible
  set nocompatible
endif
" dein.vimのディレクトリ
let s:dein_dir = expand('~/.config/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" なければgit clone
if !isdirectory(s:dein_repo_dir)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

call dein#begin(s:dein_dir)

" 管理するプラグインを記述したファイル
let s:toml = '~/.config/nvim/dein/plugins.toml'
let s:lazy_toml = '~/.config/nvim/dein/plugins_lazy.toml'

" TOML を読み込み、キャッシュしておく
if dein#load_cache([expand('<sfile>', s:toml, s:lazy_toml)])
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})
  call dein#save_cache()
endif

call dein#end()

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
" }}}



" Use deoplete.
let g:deoplete#enable_at_startup = 1

"let g:airline_powerline_fonts = 1

set background=dark
"colorscheme kalisi
colorscheme OceanicNext

"" deoplete tab-complete
"inoremap <silent><expr> <Tab> pumvisible() ? "\<C-n>" : deoplete#mappings#manual_complete()
"" ,<Tab> for regular tab
"inoremap <Leader><Tab> <Tab>

syntax enable
