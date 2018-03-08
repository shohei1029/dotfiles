set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=4 "画面上でタブ文字が占める幅
set shiftwidth=4 "自動インデントでずれる幅
set softtabstop=4 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する
"set noswapfile
set number
set showmode
set title
set showmatch " 閉じ括弧入力時に対応する括弧の強調
set clipboard=unnamed
"set clipboard+=unnamed
set ignorecase "検索の時に大文字小文字を区別しない
set smartcase "ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set wrapscan "検索時にファイルの最後まで行ったら最初に戻る
set incsearch "インクリメンタルサーチ
set hlsearch "検索文字の強調表示
set scrolloff=8 " 左右スクロール時の視界を確保


"keymapngs --
imap jj <esc>
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
"表示行単位で行移動する
nnoremap <silent> j gj
nnoremap <silent> k gk
"インサートモードでも移動
inoremap <c-d> <delete>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>

syntax on

" ---
" dein settings:
if &compatible
  set nocompatible
endif
" dein.vimのディレクトリ
let s:dein_dir = expand('~/.config/nvim/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " 管理するプラグインを記述したファイル
  let s:toml = '~/.config/nvim/dein/plugins.toml'
  let s:lazy_toml = '~/.config/nvim/dein/plugins_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
" ---


" other settings ---
let g:python3_host_prog = $PYENV_ROOT . '/shims/python3'

" Use deoplete.
let g:deoplete#enable_at_startup = 1
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"airline
let g:airline_theme= 'luna'
let g:airline_powerline_fonts = 1

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
"let g:airline#extensions#tabline#right_sep = ' '
"let g:airline#extensions#tabline#right_alt_sep = '|'
"let g:airline_left_sep = ' '
"let g:airline_left_alt_sep = '|'
"let g:airline_right_sep = ' '
"let g:airline_right_alt_sep = '|'

let NERDTreeShowHidden = 1

"-----
" docstringは表示しない jedi
autocmd FileType python setlocal completeopt-=preview

" 言語系プラグインの設定は.tomlへ移動


" vim theme
" If you have vim >=8.0 or Neovim >= 0.1.5
if (has("termguicolors"))
 set termguicolors
endif
" For Neovim 0.1.3 and 0.1.4
"let $NVIM_TUI_ENABLE_TRUE_COLOR=1

set background=dark
"colorscheme kalisi
"colorscheme OceanicNext
colorscheme hybrid

filetype plugin indent on
syntax enable
