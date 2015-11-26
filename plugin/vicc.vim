"vicc.vim - vim common configure
"vim: et ts=4 sts=4 sw=4 tw=78

if exists('g:loaded_vicc') || &compatible
    finish
endif
let g:loaded_vicc = 1

set nocompatible


"----------------------------
" load plugs
"----------------------------
let s:plugs = ['lithrad/vicc']

" set default plug groups
"
if !exists('g:cc_plug_groups')
    let g:cc_plug_groups = [
        \ 'common',
        \ 'coding',
        \ 'custom',
        \ 'disable',
    \]
endif

" -- common plugs
"
if count(g:cc_plug_groups, 'common')
    let s:plug_common = [
        \ 'EnhCommentify.vim',
        \ 'airblade/vim-gitgutter',
        \ 'bling/vim-airline',
        \ 'junegunn/vim-plug',
        \ 'kien/ctrlp.vim',
        \ 'Lokaltog/vim-easymotion',
        \ 'plasticboy/vim-markdown',
        \ 'scrooloose/nerdtree',
        \ 'Yggdroot/indentLine',
        \ 'mileszs/ack.vim',
        \ 'sjl/gundo.vim',
        \]
    call extend(s:plugs, s:plug_common)
    unlet s:plug_common
endif

" -- theme plugs
"
if count(g:cc_plug_groups, 'theme')
    let s:plug_theme = [
        \ 'altercation/vim-colors-solarized',
        \ 'morhetz/gruvbox',
        \ 'w0ng/vim-hybrid',
        \]
    call extend(s:plugs, s:plug_theme)
    unlet s:plug_theme
endif

" -- unite plugs
"
if count(g:cc_plug_groups, 'unite')
    let s:plug_unite = [
        \ 'Shougo/unite.vim',
        \]
    call extend(s:plugs, s:plug_unite)
    unlet s:plug_unite
endif

" -- coding plugs
"
if count(g:cc_plug_groups, 'coding')
    let s:plug_coding = [
        \ 'tacahiroy/ctrlp-funky',
        \ 'tpope/vim-fugitive',
        \ 'luochen1990/rainbow',
        \ 'terryma/vim-expand-region',
        \ 'terryma/vim-multiple-cursors',
        \ 'tpope/vim-surround',
        \ 'tpope/vim-repeat',
        \ 'majutsushi/tagbar',
        \ 'junegunn/vim-easy-align',
        \]
    call extend(s:plugs, s:plug_coding)
    unlet s:plug_coding
endif

" -- neocomplete plugs
"
if count(g:cc_plug_groups, 'neocomplete')
    let s:plug_neocomplete = [
        \ 'Shougo/neocomplete.vim',
        \ 'Shougo/neosnippet.vim',
        \ 'Shougo/neosnippet-snippets',
        \ 'honza/vim-snippets',
        \]
    call extend(s:plugs, s:plug_neocomplete)
    unlet s:plug_neocomplete
endif

" -- python plugs
"
if count(g:cc_plug_groups, 'python')
    let s:plug_python = [
        \ 'klen/python-mode',
        \ 'yssource/python.vim',
        \ 'python_match.vim',
        \ 'pythoncomplete',
        \]
    call extend(s:plugs, s:plug_python)
    unlet s:plug_python
endif

" -- php plugs
"
if count(g:cc_plug_groups, 'php')
    let s:plug_php = [
        \ 'spf13/PIV',
        \ 'arnaud-lb/vim-php-namespace',
        \ 'beyondwords/vim-twig',
        \]
    call extend(s:plugs, s:plug_php)
    unlet s:plug_php
endif

" -- html plugs
"
if count(g:cc_plug_groups, 'html')
    let s:plug_html = [
        \ 'mattn/emmet-vim',
        \]
    call extend(s:plugs, s:plug_html)
    unlet s:plug_html
endif

" -- custom plugs
"
if count(g:cc_plug_groups, 'custom')
    if exists('g:cc_plug_custom') && !empty(g:cc_plug_custom)
        call extend(s:plugs, g:cc_plug_custom)
    endif
endif

" -- filter disabled plugs
"
if count(g:cc_plug_groups, 'disable')
    if exists('g:cc_plug_disable') && !empty(g:cc_plug_disable)
        for p in g:cc_plug_disable
            call filter(s:plugs, 'v:val != "'.p.'"')
        endfor
    endif
endif

" set plug default path
"
if empty($PLUG_DIR)
    let $PLUG_DIR = $HOME . '/.vim/bundle'
endif

" load enabled plugs
"
if isdirectory(expand('$PLUG_DIR/vicc'))
    if !exists('g:plugs')
        set rtp+=$PLUG_DIR/vicc
        call plug#begin($PLUG_DIR)
    endif

    for p in s:plugs
        Plug p
    endfor
    call plug#end()
endif


"----------------------------
" common setting
"----------------------------
set background=dark

" trigger background
"
function! ToggleBG()
    let s:tbg = &background
    if s:tbg == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction
noremap <Leader>bg :call ToggleBG()<CR>

if has('autocmd')
    filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

" trigger syntax
"
function! ToggleSyn()
    " turn off color
    colorscheme default
    if exists('g:syntax_on')
        syntax off
    else
        syntax enable
    endif
endfunction
noremap <Leader>sn :call ToggleSyn()<CR>

set mousehide                   " hide cursor when editing
scriptencoding utf-8

if has('clipboard')
    set clipboard=unnamed
endif

" trigger virtualedit
"
function! ToggleViEd()
    let s:vied = &virtualedit
    if s:vied == 'all'
        set virtualedit=
    else
        set virtualedit=all
    endif
endfunction
noremap <Leader>ve :call ToggleViEd()<CR>

set history=1000                " store a ton of history (default is 20)
set hidden                      " allow buffer switching without saving

" trigger colorcolumn 80
function! ToggleCC()
    let s:cc = &colorcolumn
    if s:cc == ''
        set cc=80
    else
        set cc=
    endif
endfunction
noremap <Leader>cc :call ToggleCC()<CR>

" trigger line number
noremap <silent><Leader>ln :set nu!<CR>

" disable backup and swap files
"
set nobackup
set noswapfile

" surface
"
set tabpagemax=15               " only show 15 tabs
set showmode                    " display the current mode

set cursorline                  " highlight current line

if has('cmdline_info')
    set ruler                   " show the ruler
    set showcmd                 " show partial commands in status line
endif

if has('statusline')
    set laststatus=2
endif

set backspace=2
set linespace=0                 " no extra spaces between rows
set nonumber                    " line numbers off
set showmatch                   " show matching brackets
set matchtime=0                 " no blink with match
set incsearch                   " find as you type search
set hlsearch                    " highlight search terms
set nowrapscan
set winminheight=0              " windows can be 0 line height
set ignorecase                  " case insensitive search
set smartcase                   " case sensitive when uc present
set wildmenu                    " show list instead of completing
set wildmode=list:longest,full  " command <Tab> completion
set scrolloff=3                 " minium lines to keep above and below cursor
set foldenable                  " auto fold code
set list                        " show unvisualable characters
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<

" formatting
"
set autoindent                  " indent at the same level of the previous line
set smartindent
set shiftwidth=4                " use indents of 4 spaces
set shiftround
set expandtab                   " tabs are spaces, not tabs
set tabstop=4                   " an indentation every four columns
set smarttab
set softtabstop=4               " let backspace delete indent
set nojoinspaces                " prevents insert two spaces after punctuation on a join
set splitright                  " puts new vsplit window to the right of the current
set splitbelow                  " puts new split window to the bottom of the current
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set formatoptions+=m
set formatoptions+=B

" encoding and formats
"
set encoding=utf-8
set termencoding=utf-8
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,latin-1
set fileformats=unix,dos,mac

set autoread                    " auto reload if file content changed
set confirm                     " pop-up confirmation when processing unsave or RO file
set magic                       " enable regular expression
set directory-=.
set lazyredraw                  " no redraw when running macro
set linebreak                   " do not break word when wrapping line
set ttyfast
set noerrorbells                " no error bells
set novisualbell


"----------------------------
" key mapping
"----------------------------
" set mapleader
"
if !exists('g:cc_leader')
    let mapleader = ','
else
    let mapleader = g:cc_leader
endif

" easy moving through tabs and windows
"
noremap <C-J> <C-W>j<C-W>_
noremap <C-K> <C-W>k<C-W>_
noremap <C-L> <C-W>l<C-W>_
noremap <C-H> <C-W>h<C-W>_

" wrapped lines goes down/up to the next row
"
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" clear highlight search
"
noremap <Leader>l :nohlsearch<CR>

" quick save and exit
"
noremap <Leader>w :w<CR>
noremap <Leader>q :q<CR>
noremap <Leader>e :e!<CR>
noremap <Leader>sw :w !sudo tee % >/dev/null<CR>

" quick edit
"
inoremap <C-J> <Esc>o
inoremap <C-K> <Esc>O
inoremap <C-L> <Esc>ldea
inoremap <C-H> <Esc>dbxa

" quick ESC from insert mode to normal mode
"
inoremap kj <Esc>

" quick split and close window
"
noremap <Leader>v <C-W>v
noremap <Leader>s <C-W>s
noremap <Leader>k <C-W>c

" quick moving through tabs and buffers
"
noremap tn gt
noremap tp gT
noremap bn :bn<CR>
noremap bp :bp<CR>
noremap bd :bd<CR>
noremap bf :bf<CR>
noremap bl :bl<CR>

" open a new buffer with the current buffer's path
"
noremap <Leader>be :e <C-R>=expand("%:p:h")<CR>/

" tab operation
"
noremap <Leader>tn :tabnew<CR>
noremap <Leader>to :tabonly<CR>
noremap <Leader>tc :tabclose<CR>
noremap <Leader>tm :tabmove

" open a new tab with the current buffer's path
"
noremap <Leader>te :tabedit <C-R>=expand("%:p:h")<CR>/

" trim ^M and spaces
"
nnoremap <Leader>cm :%s/\r$//g<CR>:noh<CR>
nnoremap <Leader>cs :%s/\s\+$//g<CR>:noh<CR>

" change path to the current buffer's path
"
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" quick move to the head and tail of the line
"
noremap H ^
noremap L $

" place the search content to the middle of the screen
"
noremap n nzz
noremap N Nzz

" select all
"
noremap <Leader>sa `[v`]$

" select block
"
noremap <Leader>sb V`}

" visual shifting
"
vnoremap < <gv
vnoremap > >gv

" allow using the repeat operator with a visual selection
"
vnoremap . :normal .<CR>

" adjust viewports to the same size
"
noremap <Leader>= <C-W>=

" smart undo
"
nnoremap U <C-R>
inoremap <C-U> <C-G>u<C-U>

" quick move in command mode
"
cnoremap <C-J> <t_kd>
cnoremap <C-K> <t_ku>
cnoremap <C-A> <HOME>
cnoremap <C-E> <END>

" yank from the cursor to the end of the line
"
nnoremap Y y$

xnoremap p pgvy
vnoremap Q gq
nnoremap Q gqap

" find merge conflict markers
"
noremap <Leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>


"----------------------------
" plugs setting
"----------------------------
" disable plug config with cc_nofun
"
if exists('g:cc_nofun')
    finish
endif

" -- common plug config
"
if count(g:cc_plug_groups, 'common')
"{{{
"
" vim-airline
"
if isdirectory(expand('$PLUG_DIR/vim-airline'))
    let g:airline_theme = 'murmur'
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline_right_alt_sep = ':'
    let g:airline_section_z = airline#section#create_right(['%2c','%2l'])
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#buffer_nr_show = 1
endif

" ctrlp.vim
"
if isdirectory(expand('$PLUG_DIR/ctrlp.vim'))
    let g:ctrlp_map = '<Leader>ff'
    let g:ctrlp_custom_ignore = { 'dir':'\.git$' }
    if executable('ack-grep')
        let s:ctrl_fallback = 'ack-grep %s --nocolor -f'
    endif
endif

" vim-easymotion
"
if isdirectory(expand('$PLUG_DIR/vim-easymotion'))
    let g:EasyMotion_leader_key = 'f'
endif

" vim-gitgutter
"
if isdirectory(expand('$PLUG_DIR/vim-gitgutter'))
    nnoremap <Leader>gg :GitGutterToggle<CR>
    let g:gitgutter_map_keys = 0
    let g:gitgutter_enabled = 0
    let g:gitgutter_highlight_lines = 1
endif

" indentLine
"
if isdirectory(expand('$PLUG_DIR/indentLine'))
    nnoremap <Leader>il :IndentLinesToggle<CR>
endif

" vim-markdown
"
if isdirectory(expand('$PLUG_DIR/vim-markdown'))
    let g:vim_markdown_folding_disabled = 1
endif

" nerdtree
"
if isdirectory(expand('$PLUG_DIR/nerdtree'))
    let NERDTreeWinPos='left'
    let NERDTreeHighlightCursorline=1
    nnoremap <Leader>nt :NERDTreeToggle<CR>
endif

" ack.vim - ack-grep required
"
if isdirectory(expand('$PLUG_DIR/ack.vim'))
    nnoremap <silent><Leader>ag :Ack -i
endif

" gundo
"
if isdirectory(expand('$PLUG_DIR/gundo'))
    nnoremap <Leader>h :GundoToggle<CR>
endif
"
"}}}
endif

" -- theme plug config
"
if count(g:cc_plug_groups, 'theme')
"{{{
"
" vim-colors-solarized
"
if isdirectory(expand('$PLUG_DIR/vim-colors-solarized'))
    set t_Co=16
    let g:solarized_termtrans=1
    colorscheme solarized
endif
"
"}}}
endif

" -- unite plug config
"
if count(g:cc_plug_groups, 'unite')
"{{{
"
" unite.vim
"
if isdirectory(expand('$PLUG_DIR/unite.vim'))
    let g:unite_sourcce_history_yank_enable = 1
    call unite#filters#matcher_default#use(['matcher_fuzzy'])
    nnoremap <Leader>ut :<C-u>Unite -no-split -buffer-name=files   -start-insert file_rec/async:!<CR>
    nnoremap <Leader>uf :<C-u>Unite -no-split -buffer-name=files   -start-insert file<CR>
    nnoremap <Leader>ur :<C-u>Unite -no-split -buffer-name=mru     -start-insert file_mru<CR>
    nnoremap <Leader>uo :<C-u>Unite -no-split -buffer-name=outline -start-insert outline<CR>
    nnoremap <Leader>uy :<C-u>Unite -no-split -buffer-name=yank    history/yank<CR>
    nnoremap <Leader>ue :<C-u>Unite -no-split -buffer-name=buffer  buffer<CR>

    " custom mappings for the unite buffer
    autocmd FileType unite call s:unite_settings()
    function! s:unite_settings()
        " play nice with supertab
        let b:SuperTabDisabled=1
        " enable navigation with control-j and control-k in insert mode
        imap <buffer><C-j> <Plug>(unite_select_next_line)
        imap <buffer><C-k> <Plug>(unite_select_previous_line)
    endfunction
endif
"
"}}}
endif

" -- coding plug config
"
if count(g:cc_plug_groups, 'coding')
"{{{
"
" ctrlp-funky
"
if isdirectory(expand('$PLUG_DIR/ctrlp-funky'))
    let g:ctrlp_funky_syntax_highlight = 1
    let g:ctrlp_extensions = ['funky']
    nnoremap <Leader>cf :CtrlPFunky<CR>
endif

" vim-fugitive
"
if isdirectory(expand('$PLUG_DIR/vim-fugitive'))
    nnoremap <silent><Leader>gs :Gstatus<CR>
    nnoremap <silent><Leader>gd :Gdiff<CR>
    nnoremap <silent><Leader>gc :Gcommit<CR>
endif

" rainbow
"
if isdirectory(expand('$PLUG_DIR/rainbow'))
    let g:rainbow_active = 0
    nnoremap <Leader>rb :RainbowToggle<CR>
endif

" vim-expand-region
"
if isdirectory(expand('$PLUG_DIR/vim-expand-region'))
    vmap v <Plug>(expand_region_expand)
    vmap <C-V> <Plug>(expand_region_shrink)
endif

" vim-easy-align
"
if isdirectory(expand('$PLUG_DIR/vim-easy-align'))
    nmap ga <Plug>(EasyAlign)
    xmap ga <Plug>(EasyAlign)
endif

" tagbar - ctags required
"
if isdirectory(expand('$PLUG_DIR/tagbar'))
    nnoremap <Leader>tg :TagbarToggle<CR>
endif
"
"}}}
endif

" -- neocomplete plug config
"
if count(g:cc_plug_groups, 'neocomplete')
"{{{
"
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_auto_delimiter = 1
let g:neocomplete#max_list = 15
let g:neocomplete#force_overwrite_completefunc = 1
"
"}}}
endif

" -- python plug config
"
if count(g:cc_plug_groups, 'python')
"{{{
"
" pymode
"
if !has('python') && !has('python3')
    let g:pymode = 0
endif

" python-mode
if isdirectory(expand('$PLUG_DIR/python-mode'))
    let g:pymode_lint_checkers = ['pyflakes']
    let g:pymode_trim_whitespaces = 0
    let g:pymode_options = 0
    let g:pymode_rope = 0
endif
"
"}}}
endif

" -- php plug config
"
if count(g:cc_plug_groups, 'php')
"{{{
"
" PIV
"
if isdirectory(expand('$PLUG_DIR/PIV'))
    let g:DisableAutoPHPFolding = 0
    let g:PIVAutoClose = 0
endif
"
"}}}
endif


"----------------------------
" gui setting
"----------------------------
if has('gui_running')
    set guioptions+=mTLrb
    set guioptions-=mTLrb
    set shortmess=atI

    set guicursor=n-v-c:hor8-blinkon0
    set guifont=Terminus\ 9,
              \ Andale\ Mono\ Regular\ 9,
              \ Ubuntu\ Mono\ Regular\ 9,
              \ Courier\ New\ Regular\ 9,

    highlight Cursor gui=NONE guibg=deeppink
endif
