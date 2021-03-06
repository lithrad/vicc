vicc
====

Vim common configuration.

## Installation

Configure vimrc like:
```vim
" custom plugin
let g:cc_plug_custom = [
\  'a.vim',
\  'ctags.vim',
\]

" set plugin source path
let $PLUG_DIR = expand('$HOME/.vim/bundle')

" load config file
source $PLUG_DIR/vicc/plugin/vicc.vim

" append custom plugins
Plug 'a.vim'
Plug 'ctags.vim'
call plug#end()
```

Install Dependencies:
```Bash
# ubuntu
apt-get install ack-grep ctags
```

## Management

[junegunn/vim-plug](https://github.com/junegunn/vim-plug)

| Command                   | Description                                          |
| ------------------------- | ---------------------------------------------------- |
| PlugInstall/Update [name] | Install or update                                    |
| PlugClean[ ! ]            | Remove unused directories                            |
| PlugUpgrade               | Upgrade vim-plug self                                |
| PlugStatus                | Check the status of plugins                          |
| PlugDiff                  | See the updated changes from the previous PlugUpdate |
| PlugSnapshot [output path]| Generate script for restoring the current plugins    |
