"vimcc.vim - vim common configure.
"vim: set ts=4 sts=4 sw=4 tw=78

if exists("g:loaded_vimcc") || &compatible
    finish
endif
let g:loaded_vimcc = 1


"----------------------------
" bundle configure
"----------------------------

" bundle list
let s:plugs = [
\  'EnhCommentify.vim',
\  'airblade/vim-gitgutter',
\  'altercation/vim-colors-solarized',
\  'bling/vim-airline',
\  'junegunn/vim-plug',
\  'kien/ctrlp.vim',
\  'lithrad/vimcc',
\  'Lokaltog/vim-easymotion',
\  'plasticboy/vim-markdown',
\  'scrooloose/nerdtree',
\  'Yggdroot/indentLine',
\
\  'mileszs/ack.vim',
\  'sjl/gundo.vim',
\  'terryma/vim-expand-region',
\  'terryma/vim-multiple-cursors',
\  'tpope/vim-surround',
\]

" set default bundle path
if empty($PLUG_DIR)
    let $PLUG_DIR = expand('$HOME/.vim/bundle')
endif

" custom plugs
if exists('g:my_plugs')
    call extend(s:plugs, g:my_plugs)
endif

" load plugs
let $VI_PLUG = expand('$PLUG_DIR/vim-plug/plug.vim')

if filereadable($VI_PLUG)
    source $VI_PLUG
else
    set rtp+=$PLUG_DIR/vimcc
endif

" load vim-plug cautiously
if !exists('g:plugs')
call plug#begin($PLUG_DIR)
endif

for p in s:plugs
    Plug p
endfor
call plug#end()


"----------------------------
" plugs configure
"----------------------------
" airline
let g:airline_theme = 'murmur'
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ':'
let g:airline_section_z = airline#section#create_right(['%2c','%2l'])
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1

" ctrlp
let g:ctrlp_map = '<Leader>ff'
let g:ctrlp_custom_ignore = { 'dir':'\.git$' }
if executable('ack-grep')
    let s:ctrl_fallback = 'ack-grep %s --nocolor -f'
endif

" easymotion
let g:EasyMotion_leader_key = 'f'

" gitgutter
nnoremap <Leader>gd :GitGutterToggle<CR>
let g:gitgutter_map_keys = 0
let g:gitgutter_enabled = 0
let g:gitgutter_highlight_lines = 1

" indentLine
nnoremap <Leader>il :IndentLinesToggle<CR>

" markdown
let g:vim_markdown_folding_disabled = 1

" nerdtree
nnoremap <Leader>nt :NERDTreeToggle<CR>

" solarized
set t_Co=16
let g:solarized_termtrans=1
set background=dark
colorscheme solarized

" ack
nnoremap <silent><Leader>a :Ack -i

" expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-V> <Plug>(expand_region_shrink)

" gundo
nnoremap <Leader>h :GundoToggle<CR>


"----------------------------
" common configure
"----------------------------
if has('autocmd')
    filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
    syntax enable
endif

set autoindent
set autoread
set backspace=2
set clipboard=unnamed
set cindent
set confirm
set cursorline
set directory-=.
set encoding=utf-8
set expandtab
set ffs=unix,dos,mac
set fileencoding=utf-8
set fileencodings=utf-8,ucs-bom,cp936,latin-1
set hidden
set hlsearch
set ignorecase
set incsearch
set iskeyword+=_,$,@,%,#,-
set laststatus=2
set lazyredraw
set linebreak
set list
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<
set magic
set nobackup
set nocompatible
set noeb
set noswapfile
set nowrapscan
set number
set scrolloff=3
set shiftround
set shiftwidth=4
set showcmd
set softtabstop=4
set smartcase
set smartindent
set smarttab
set tabstop=4
set termencoding=utf-8
set textwidth=500
set ttyfast
set undolevels=1000
set wildmenu
set wildmode=longest,list,full


"----------------------------
" keymap configure
"----------------------------
noremap <C-H> <C-W>h
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l

nnoremap <Leader>e :e!<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>sw :w !sudo tee % >/dev/null<CR>

nnoremap <Leader>v <C-W>v
nnoremap <Leader>s <C-W>s
nnoremap <Leader>k <C-W>c

inoremap kj <Esc>
inoremap <C-H> <Esc>dbxa
inoremap <C-J> <Esc>o
inoremap <C-K> <Esc>O
inoremap <C-L> <Esc>ldea

nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j
xnoremap p pgvy
vnoremap Q gq
nnoremap Q gqap
nnoremap Y y$
nnoremap tn gt
nnoremap tp gT
nnoremap bn :bn<CR>
nnoremap bp :bp<CR>
nnoremap bd :bd<CR>
nnoremap bf :bf<CR>
nnoremap bl :bl<CR>

nnoremap <Leader>cs :%s/\s\+$//g<CR>:noh<CR>
nnoremap <Leader>cm :%s/\r$//g<CR>:noh<CR>

noremap <Leader>tn :tabnew<CR>
noremap <Leader>to :tabonly<CR>
noremap <Leader>tc :tabclose<CR>
noremap <Leader>tm :tabmove
noremap <Leader>te :tabedit <C-R>=expand("%:p:h")<CR>/

noremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

noremap H ^
noremap L $
noremap n nzz
noremap N Nzz

noremap gV `[v`]$
vnoremap < <gv
vnoremap > >gv

nnoremap U <C-R>
inoremap <C-U> <C-G>u<C-U>

nnoremap <silent><Leader>l :nohlsearch<CR>

cnoremap <C-J> <t_kd>
cnoremap <C-K> <t_ku>
cnoremap <C-A> <HOME>
cnoremap <C-E> <END>


"----------------------------
" other configure
"----------------------------

" toggle background
function! ToggleBG()
    let s:tbg = &background

    if s:tbg == "dark"
        set background=light
    else
        set background=dark
    endif
endfunction
noremap <Leader>bg :call ToggleBG()<CR>

" toggle syntax
function! ToggleSyn()
    if exists('g:syntax_on')
        syntax off
    else
        syntax enable
    endif
endfunction
noremap <Leader>sn :call ToggleSyn()<CR>
