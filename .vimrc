" jediは無効化

set nocompatible
" scriptencoding cp932
"scriptencodingと、このファイルのエンコーディングが一致するよう注意！
"scriptencodingは、vimの内部エンコーディングと同じものを推奨します。
"改行コードは set fileformat=unix に設定するとunixでも使えます。

" no tab 
set expandtab
"----------------------------------------
" システム設定
"----------------------------------------

"ファイルの上書きの前にバックアップを作る/作らない
"set writebackupを指定してもオプション 'backup' がオンでない限り、
"バックアップは上書きに成功した後に削除される。
set nowritebackup
"バックアップ/スワップファイルを作成する/しない
set nobackup
"set noswapfile
"再読込、vim終了後も継続するアンドゥ(7.3)
if version >= 703
  "Persistent undoを有効化(7.3)
  set undofile
  "アンドゥの保存場所(7.3)
  set undodir=.
endif
"viminfoを作成しない
"set viminfo=
"クリップボードを共有
set clipboard+=unnamed
"8進数を無効にする。<C-a>,<C-x>に影響する
set nrformats-=octal
"キーコードやマッピングされたキー列が完了するのを待つ時間(ミリ秒)
set timeoutlen=3500
"編集結果非保存のバッファから、新しいバッファを開くときに警告を出さない
set hidden
"ヒストリの保存数
set history=50
"日本語の行の連結時には空白を入力しない
set formatoptions+=mM
"Visual blockモードでフリーカーソルを有効にする
set virtualedit=block
"カーソルキーで行末／行頭の移動可能に設定
set whichwrap=b,s,[,],<,>
"バックスペースでインデントや改行を削除できるようにする
set backspace=indent,eol,start
"□や○の文字があってもカーソル位置がずれないようにする
set ambiwidth=double
"コマンドライン補完するときに強化されたものを使う
set wildmenu
"マウスを有効にする
if has('mouse')
  set mouse=a
endif
"pluginを使用可能にする
filetype plugin indent on

"----------------------------------------
" 検索
"----------------------------------------
"検索の時に大文字小文字を区別しない
"ただし大文字小文字の両方が含まれている場合は大文字小文字を区別する
set ignorecase
set smartcase
"検索時にファイルの最後まで行ったら最初に戻る
set wrapscan
"インクリメンタルサーチ
set incsearch
"検索文字の強調表示
set hlsearch
"w,bの移動で認識する文字
"set iskeyword=a-z,A-Z,48-57,_,.,-,>
"vimgrep をデフォルトのgrepとする場合internal
"set grepprg=internal

"----------------------------------------
" 表示設定
"----------------------------------------
"スプラッシュ(起動時のメッセージ)を表示しない
"set shortmess+=I
"エラー時の音とビジュアルベルの抑制(gvimは.gvimrcで設定)
set noerrorbells
set novisualbell
set visualbell t_vb=
"マクロ実行中などの画面再描画を行わない
"set lazyredraw
"Windowsでディレクトリパスの区切り文字表示に / を使えるようにする
set shellslash
"行番号表示
set number
"括弧の対応表示時間
" set showmatch matchtime=1
"タブを設定
set ts=4 sw=4 sts=4
"自動的にインデントする
set autoindent
"Cインデントの設定
set cinoptions+=:0
"タイトルを表示
set title
"コマンドラインの高さ (gvimはgvimrcで指定)
set cmdheight=2
set laststatus=2
"コマンドをステータス行に表示
set showcmd
"画面最後の行をできる限り表示する
set display=lastline
"Tab、行末の半角スペースを明示的に表示する
" set list
" set listchars=tab:^\ ,trail:~

syntax enable
syntax on


""""""""""""""""""""""""""""""
"ステータスラインに文字コードやBOM、16進表示等表示
"iconvが使用可能の場合、カーソル上の文字コードをエンコードに応じた表示にするFencB()を使用
""""""""""""""""""""""""""""""
if has('iconv')
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=[0x%{FencB()}]\ (%v,%l)/%L%8P\ 
else
  set statusline=%<%f\ %m\ %r%h%w%{'['.(&fenc!=''?&fenc:&enc).(&bomb?':BOM':'').']['.&ff.']'}%=\ (%v,%l)/%L%8P\ 
endif

function! FencB()
  let c = matchstr(getline('.'), '.', col('.') - 1)
  let c = iconv(c, &enc, &fenc)
  return s:Byte2hex(s:Str2byte(c))
endfunction

function! s:Str2byte(str)
  return map(range(len(a:str)), 'char2nr(a:str[v:val])')
endfunction

function! s:Byte2hex(bytes)
  return join(map(copy(a:bytes), 'printf("%02X", v:val)'), '')
endfunction

"----------------------------------------
" ノーマルモード
"----------------------------------------
"ヘルプ検索
nnoremap <F1> K
"現在開いているvimスクリプトファイルを実行
nnoremap <F8> :source %<CR>
"強制全保存終了を無効化
nnoremap ZZ <Nop>
"カーソルをj k では表示行で移動する。物理行移動は<C-n>,<C-p>
"キーボードマクロには物理行移動を推奨
"h l はノーマルモードのみ行末、行頭を超えることが可能に設定(whichwrap) 
" zvはカーソル位置の折り畳みを開くコマンド
nnoremap <Down> gj
nnoremap <Up>   gk
nnoremap h <Left>zv
nnoremap j gj
nnoremap k gk
nnoremap l <Right>zv

""""""""""""""""""""""""""""""
"挿入モード時、ステータスラインの色を変更
""""""""""""""""""""""""""""""
let g:hi_insert = 'highlight StatusLine guifg=darkblue guibg=darkyellow gui=none ctermfg=blue ctermbg=yellow cterm=none'

if has('syntax')
  augroup InsertHook
    autocmd!
    autocmd InsertEnter * call s:StatusLine('Enter')
    autocmd InsertLeave * call s:StatusLine('Leave')
  augroup END
endif
" if has('unix') && !has('gui_running')
"   " ESCでキー入力待ちになる対策
"   inoremap <silent> <ESC> <ESC>
" endif

let s:slhlcmd = ''
function! s:StatusLine(mode)
  if a:mode == 'Enter'
    silent! let s:slhlcmd = 'highlight ' . s:GetHighlight('StatusLine')
    silent exec g:hi_insert
  else
    highlight clear StatusLine
    silent exec s:slhlcmd
    redraw
  endif
endfunction

function! s:GetHighlight(hi)
  redir => hl
  exec 'highlight '.a:hi
  redir END
  let hl = substitute(hl, '[\r\n]', '', 'g')
  let hl = substitute(hl, 'xxx', '', '')
  return hl
endfunction


" ☆-------------------------------------☆
" 環境設定系
" シンタックスハイライト
syntax on
" エンコード
set encoding=utf8
" ファイルエンコード
set fileencoding=utf-8
" ?encoding
set termencoding=utf-8
" スクロールする時に下が見えるようにする
set scrolloff=5
" .swapファイルを作らない
set noswapfile
" バックアップファイルを作らない
set nowritebackup
" バックアップをしない
set nobackup
" バックスペースで各種消せるようにする
set backspace=indent,eol,start
" ビープ音を消す
set vb t_vb=
set novisualbell
" OSのクリップボードを使う
set clipboard+=unnamed
set clipboard=unnamed
" 不可視文字を表示
" set list
" 行番号を表示
set number
" 右下に表示される行・列の番号を表示する
set ruler
" compatibleオプションをオフにする
set nocompatible
" 移動コマンドを使ったとき、行頭に移動しない
set nostartofline
" 対応括弧に<と>のペアを追加
set matchpairs& matchpairs+=<:>
" 対応括弧をハイライト表示する
set showmatch
" 対応括弧の表示秒数を3秒にする
" set matchtime=3
" ウィンドウの幅より長い行は折り返され、次の行に続けて表示される
set wrap
" 入力されているテキストの最大幅を無効にする
set textwidth=0
" 不可視文字を表示
" set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲
" インデントをshiftwidthの倍数に丸める
set shiftround
" 補完の際の大文字小文字の区別しない
set infercase
" 文字がない場所にもカーソルを移動できるようにする
" set virtualedit=all
" 変更中のファイルでも、保存しないで他のファイルを表示
set hidden
" 新しく開く代わりにすでに開いてあるバッファを開く
set switchbuf=useopen
" 小文字の検索でも大文字も見つかるようにする
set ignorecase
" ただし大文字も含めた検索の場合はその通りに検索する
set smartcase
" インクリメンタルサーチを行う
set incsearch
" 検索結果をハイライト表示
:set hlsearch
" コマンド、検索パターンを10000個まで履歴に残す
set history=10000
" マウスモード有効
" set mouse=a
" xtermとscreen対応
set ttymouse=xterm2
" コマンドを画面最下部に表示する
set showcmd


" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %
" 入力モード中に素早くJJと入力した場合はESCとみなす
inoremap jj <Esc>
" ESCを二回押すことでハイライトを消す
nmap <silent> <Esc><Esc> :nohlsearch<CR>
" カーソル下の単語を * で検索
vnoremap <silent> * "vy/\V<C-r>=substitute(escape(@v, '\/'), "\n", '\\n', 'g')<CR><CR>
" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz
" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk
" vを二回で行末まで選択
vnoremap v $h
" TABにて対応ペアにジャンプ
nnoremap &lt;Tab&gt; %
vnoremap &lt;Tab&gt; %
" Ctrl + hjkl でウィンドウ間を移動
" nnoremap <C-h> <C-w>h
" nnoremap <C-j> <C-w>j
" nnoremap <C-k> <C-w>k
" nnoremap <C-l> <C-w>l
" Shift + 矢印でウィンドウサイズを変更
" nnoremap <S-Left>  <C-w><<CR>
" nnoremap <S-Right> <C-w><CR>
" nnoremap <S-Up>    <C-w>-<CR>
" nnoremap <S-Down>  <C-w>+<CR>
" T + ? で各種設定をトグル
"nnoremap [toggle] <Nop>
"nmap T [toggle]
"nnoremap <silent> [toggle]s :setl spell!<CR>:setl spell?<CR>
"nnoremap <silent> [toggle]l :setl list!<CR>:setl list?<CR>
"nnoremap <silent> [toggle]t :setl expandtab!<CR>:setl expandtab?<CR>
"nnoremap <silent> [toggle]w :setl wrap!<CR>:setl wrap?<CR>
 
" :e などでファイルを開く際にフォルダが存在しない場合は自動作成
function! s:mkdir(dir, force)
  if !isdirectory(a:dir) && (a:force ||
        \ input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
    call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
  endif
endfunction

"表示行単位で行移動する
nnoremap <silent> j gj
nnoremap <silent> k gk
"インサートモードでも移動
inoremap <c-d> <delete>
inoremap <c-j> <down>
inoremap <c-k> <up>
inoremap <c-h> <left>
inoremap <c-l> <right>
"画面切り替え
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-l> <c-w>l
nnoremap <c-h> <c-w>h
"<space>j, <space>kで画面送り
noremap [Prefix]j <c-f><cr><cr>
noremap [Prefix]k <c-b><cr><cr>




" ☆-------------------------------------☆
set scrolloff=8 " 左右スクロール時の視界を確保
set confirm    " 保存されていないファイルがあるときは終了前に保存確認
set smartcase  " 大文字と小文字が混在した言葉で検索を行った場合に限り、大文字と小文字を区別する

" clip bord (vim)
set clipboard=unnamed,autoselect

highlight LineNr ctermfg=2  
nnoremap <Space>  <C-E>
nnoremap <S-Space> <C-Y>

" for japanese set
" if &encoding !=# 'utf-8'
" 	set encoding=japan
" 	set fileencoding=japan
" endif
" if has('iconv')
" 	let s:enc_euc = 'euc-jp'
" 	let s:enc_jis = 'iso-2022-jp'
" 	if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
" 		let s:enc_euc = 'eucjp-ms'
" 		let s:enc_jis = 'iso-2022-jp-3'
" 	elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
" 		let s:enc_euc = 'euc-jisx0213'
" 		let s:enc_jis = 'iso-2022-jp-3'
" 	endif
" 	if &encoding ==# 'utf-8'
" 		let s:fileencodings_default = &fileencodings
" 		if has('mac')
" 			let &fileencodings = s:enc_jis .','. s:enc_euc
" 			let &fileencodings = &fileencodings .','. s:fileencodings_default
" 		else
" 			let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
" 			let &fileencodings = &fileencodings .','. s:fileencodings_default
" 		endif
" 		unlet s:fileencodings_default
" 	else
" 		let &fileencodings = &fileencodings .','. s:enc_jis
" 		set fileencodings+=utf-8,ucs-2le,ucs-2
" 		if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
" 			set fileencodings+=cp932
" 			set fileencodings-=euc-jp
" 			set fileencodings-=euc-jisx0213
" 			set fileencodings-=eucjp-ms
" 			let &encoding = s:enc_euc
" 			let &fileencoding = s:enc_euc
" 		else
" 			let &fileencodings = &fileencodings .','. s:enc_euc
" 		endif
" 	endif
" 	unlet s:enc_euc
" 	unlet s:enc_jis
" endif


"" PATHの自動更新関数
"" | 指定された path が $PATH に存在せず、ディレクトリとして存在している場合
"" | のみ $PATH に加える
"function! IncludePath(path)
"  " define delimiter depends on platform
"  if has('win16') || has('win32') || has('win64')
"    let delimiter = ";"
"  else
"    let delimiter = ":"
"  endif
"  let pathlist = split($PATH, delimiter)
"  if isdirectory(a:path) && index(pathlist, a:path) == -1
"    let $PATH=a:path.delimiter.$PATH
"  endif
"endfunction
"
"" ~/.pyenv/shims を $PATH に追加する
"" これを行わないとpythonが正しく検索されない
"IncludePath(expand("~/.pyenv/shims"))

" 上記設定だとエラーがでるため
" ~/.pyenv/shimsを$PATHに追加
" jedi-vim や vim-pyenc のロードよりも先に行う必要がある、はず。
let $PATH = "~/.pyenv/shims:".$PATH


"--------------------------------------------------------------------------------------
" Start Neobundle Settings.
"---------------------------

let $VIMBUNDLE = '~/.vim/bundle'
let $NEOBUNDLEPATH = $VIMBUNDLE . '/neobundle.vim'
if stridx(&runtimepath, $NEOBUNDLEPATH) != -1
" If the NeoBundle doesn't exist. -> install
command! NeoBundleInit try | call s:neobundle_init()
            \| catch /^neobundleinit:/
                \|   echohl ErrorMsg
                \|   echomsg v:exception
                \|   echohl None
                \| endtry

function! s:neobundle_init()
    redraw | echo "Installing neobundle.vim..."
    if !isdirectory($VIMBUNDLE)
        call mkdir($VIMBUNDLE, 'p')
        echo printf("Creating '%s'.", $VIMBUNDLE)
    endif
    cd $VIMBUNDLE

    if executable('git')
        call system('git clone git://github.com/Shougo/neobundle.vim')
        if v:shell_error
            throw 'neobundleinit: Git error.'
        endif
    endif

    set runtimepath& runtimepath+=$NEOBUNDLEPATH
    call neobundle#rc($VIMBUNDLE)
    try
        echo printf("Reloading '%s'", $MYVIMRC)
        source $MYVIMRC
    catch
        echohl ErrorMsg
        echomsg 'neobundleinit: $MYVIMRC: could not source.'
        echohl None
        return 0
    finally
        echomsg 'Installed neobundle.vim'
    endtry

    echomsg 'Finish!'
endfunction

autocmd! VimEnter * redraw
            \ | echohl WarningMsg
            \ | echo "You should do ':NeoBundleInit' at first!"
            \ | echohl None
endif

" bundleで管理するディレクトリを指定
set runtimepath+=~/.vim/bundle/neobundle.vim/
 
" Required:
call neobundle#begin(expand('~/.vim/bundle/'))
 
" neobundle自体をneobundleで管理
NeoBundleFetch 'Shougo/neobundle.vim'
 
NeoBundle 'tpope/vim-surround'

" neocomplete.vim
NeoBundle "Shougo/neocomplete.vim"

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'
" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
			\ 'default' : '',
			\ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
	let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
" inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
	return neocomplete#close_popup() . "\<CR>"
	" For no inserting <CR> key.
	return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For smart TAB completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
"        \ <SID>check_back_space() ? "\<TAB>" :
"        \ neocomplete#start_manual_complete()
"  function! s:check_back_space() "{{{
"    let col = col('.') - 1
"    return !col || getline('.')[col - 1]  =~ '\s'
"  endfunction"}}}

"jedi無効化のため有効化
"jedi-vimの補完を使うので不要
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete




" カラースキーム一覧表示に Unite.vim を使う
NeoBundle 'Shougo/unite.vim'
NeoBundle 'ujihisa/unite-colorscheme'
"colorscheme 
NeoBundleLazy 'chriskempson/vim-tomorrow-theme'
NeoBundle 'w0ng/vim-hybrid'
NeoBundleLazy 'altercation/vim-colors-solarized'

"syntax on
set background=dark
if ($ft=='ruby')
	colorscheme Tomorrow-Night
else
	colorscheme hybrid
	let g:hybrid_use_iTerm_colors = 1
endif

" hybridの設定
" let g:hybrid_use_iTerm_colors = 1
" colorscheme hybrid


" solarizedの設定   Darkテーマ
" let g:solarized_termcolors=16
" let g:solarized_termtrans=0
" let g:solarized_degrade=0
" let g:solarized_bold=1
" let g:solarized_underline=1
" let g:solarized_italic=1
" let g:solarized_contrast='normal'
" let g:solarized_visibility='normal'
" syntax enable
" set background=dark
" colorscheme solarized


" NeoBundle 'klen/python-mode7

NeoBundleLazy 'Lokaltog/vim-easymotion'
" vim-easymotion {{{
let g:EasyMotion_do_mapping = 0
nmap s <Plug>(easymotion-s2)
xmap s <Plug>(easymotion-s2)
omap z <Plug>(easymotion-s2)
nmap g/ <Plug>(easymotion-sn)
xmap g/ <Plug>(easymotion-sn)
omap g/ <Plug>(easymotion-tn)
let g:EasyMotion_smartcase = 1
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
let g:EasyMotion_startofline = 0
let g:EasyMotion_keys = 'QZASDFGHJKL;'
let g:EasyMotion_use_upper = 1
let g:EasyMotion_enter_jump_first = 1
" }}}

"括弧を自動で閉じてくれる奴
"NeoBundle 'Townk/vim-autoclose'
"NeoBundle 'cohama/lexima'
NeoBundle 'https://github.com/cohama/lexima.vim' 

NeoBundle 'LeafCage/yankround.vim'
" ヤンク履歴を保持してくれるやつ
" ペースト後に<C-p>か<C-n>を押してヤンク履歴をペーストできる
" いわゆるコピペ拡張
" unite.vim と連携することで、(この設定では)\<C-p>で履歴一覧から絞り込み検索が可能
" yankround.vim {{{
nmap p <Plug>(yankround-p)
nmap P <Plug>(yankround-P)
nmap <C-p> <Plug>(yankround-prev)
nmap <C-n> <Plug>(yankround-next)
let g:yankround_max_history = 100
nnoremap <Leader><C-p> :<C-u>Unite yankround<CR>
"}}}


NeoBundle 'scrooloose/syntastic'  
NeoBundleLazy 'kien/ctrlp.vim'
NeoBundleLazy 'scrooloose/nerdtree'
NeoBundle 'Shougo/vimproc.vim', {
			\ 'build' : {
			\     'windows' : 'tools\\update-dll-mingw',
			\     'cygwin' : 'make -f make_cygwin.mak',
			\     'mac' : 'make -f make_mac.mak',
			\     'unix' : 'make -f make_unix.mak',
			\    },
			\ }
	
" quickrun   "to use :QuickRun hoge
NeoBundle 'thinca/vim-quickrun'
" 実行したら左側に出てくるの阻止
" runner/vimproc/updatetime で出力バッファの更新間隔をミリ秒で設定できます
" updatetime が一時的に書き換えられてしまうので注意して下さい
let g:quickrun_config = {
\   "_" : {
\       "outputter/buffer/split" : ":botright",
\       "outputter/buffer/close_on_empty" : 1,
\       "runner" : "vimproc",
\       "runner/vimproc/updatetime" : 60
\   },
\}
" C-cで強制終了
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"


" カーソル位置の単語をヤンクした単語に置換
nnoremap <silent> ciy ciw<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> cy   ce<C-r>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy   c<C-r>0<ESC>:let@/=@1<CR>:noh<CR>

NeoBundleLazy 'JuliaLang/julia-vim'

" Ruby
NeoBundleLazy 'vim-ruby/vim-ruby'


" Haskell
NeoBundleLazy 'dag/vim2hs'
"NeoBundle 'kana/vim-filetype-haskell' "インデントプラグイン
NeoBundleLazy 'ujihisa/neco-ghc'
NeoBundleLazy 'eagletmt/ghcmod-vim' " 静的解析ツールのghcmodをvimと連携,:GhcModTypeとかで。

" python
""NeoBundle 'davidhalter/jedi-vim'
"NeoBundleLazy "davidhalter/jedi-vim", {
"      \ "autoload": {
"      \   "filetypes": ["python", "python3", "djangohtml"]
"      \ }}

" docstringは表示しない
autocmd FileType python setlocal completeopt-=preview

"" neocompleteとjediを連携
"autocmd FileType python setlocal omnifunc=jedi#completions
"let g:jedi#completions_enabled = 0
"let g:jedi#auto_vim_configuration = 0
"if !exists('g:neocomplete#force_omni_input_patterns')
"        let g:neocomplete#force_omni_input_patterns = {}
"endif
""let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'
"
" 上記設定で不具合発生のため，下記を試してみてる
"if ! empty(neobundle#get("jedi-vim"))
"  let g:jedi#auto_initialization = 1
"  let g:jedi#auto_vim_configuration = 1
"
"  nnoremap [jedi] <Nop>
"  xnoremap [jedi] <Nop>
"  nmap <Leader>j [jedi]
"  xmap <Leader>j [jedi]
"
"  let g:jedi#completions_command = "<C-N>"
"  let g:jedi#goto_assignments_command = "[jedi]g"
"  let g:jedi#goto_definitions_command = "[jedi]d"
"  let g:jedi#documentation_command = "[jedi]K"
"  let g:jedi#rename_command = "[jedi]r"
"  let g:jedi#usages_command = "[jedi]n"
"  let g:jedi#popup_select_first = 0
"  let g:jedi#popup_on_dot = 0
"
"  autocmd FileType python setlocal completeopt-=preview
"
"  " for w/ neocomplete
"  if ! empty(neobundle#get("neocomplete.vim"))
"    autocmd FileType python setlocal omnifunc=jedi#completions
"    let g:jedi#completions_enabled = 0
"    let g:jedi#auto_vim_configuration = 0
"    "let g:neocomplete#force_omni_input_patterns.python = '\%([^. \t]\.\|^\s*@\|^\s*from\s.\+import \|^\s*from \|^\s*import \)\w*'
"  endif
"endif



" pyenv 処理用に vim-pyenv を追加
" Note: depends が指定されているため jedi-vim より後にロードされる
NeoBundleLazy "lambdalisue/vim-pyenv", {
      \ "autoload": {
      \   "filetypes": ["python", "python3", "djangohtml"]
      \ }}
"       \ "depends": ['davidhalter/jedi-vim'],


"for Perl
" 保存時に自動でsyntax check
" autocmd BufNewFile,BufRead *.psgi   set filetype=perl
" autocmd BufNewFile,BufRead *.t      set filetype=perl
" inoremap <C-d> $
" inoremap <C-a> @

" Processing
NeoBundleLazy 'sophacles/vim-processing'
augroup Processing
    autocmd!
    autocmd BufNewFile *.pde NeoBundleSource vim-processing
    autocmd BufRead    *.pde NeoBundleSource vim-processing
augroup END


" jazzradio.vim
"NeoBundleLazy 'supermomonga/jazzradio.vim', { 'depends' : [ 'Shougo/unite.vim' ] }
"if neobundle#tap('jazzradio.vim')
"	call neobundle#config({
"				\   'autoload' : {
"				\     'unite_sources' : [
"				\       'jazzradio'
"				\     ],
"				\     'commands' : [
"				\       'JazzradioUpdateChannels',
"				\       'JazzradioStop',
"				\       {
"				\         'name' : 'JazzradioPlay',
"				\         'complete' : 'customlist,jazzradio#channel_id_complete'
"				\       }
"				\     ],
"				\     'function_prefix' : 'jazzradio'
"				\   }
"				\ })
"endif


NeoBundleCheck
call neobundle#end()


" autocloseの設定
" 文末以外では無効になって欲しい
call lexima#add_rule({'at': '\%#.*[-0-9a-zA-Z_,:]', 'char': '{', 'input': '{'})
" 自動クローズした文字が次の行にあってもタイプできるように
call lexima#add_rule({'at': '\%#\n\s*}', 'char': '}', 'input': '}', 'delete': '}'})

 
" Required:
" filetype plugin indent on
 
" 未インストールのプラグインがある場合、インストールするかどうかを尋ねてくれるようにする設定
" 毎回聞かれると邪魔な場合もあるので、この設定は任意です。
" NeoBundleCheck
 
"-------------------------
" End Neobundle Settings.
"-----------------------------------------------------------------------


" ~/.vimrc.localが存在する場合のみ設定を読み込む
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif

