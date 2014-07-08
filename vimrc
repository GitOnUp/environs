" A great deal of this is lifted from csswizardry's excellent .vimrc file:
" https://github.com/csswizardry/dotfiles/blob/master/.vimrc
" Thanks to him for providing the final push for me to learn it.

" Disable compatibility
set nocompatible
set encoding=utf-8
" Tabs are spaces.  This is a coding convention for work I've adapted to.
set expandtab
" Tab width 4 for a variety of situations.
set shiftwidth=4
set tabstop=4
set softtabstop=4
" Round indents to nearest multiple of 4
set shiftround

" Pretty colors
syntax enable
set t_Co=256
set background=dark
colorscheme solarized

" Show 3 lines at top and bottom of screen when scrolling.
set scrolloff=3
" Disable line wrapping
set nowrap
" Show 5 characters when scrolling left to right.
set sidescrolloff=5
" Scroll sideways by characters
set sidescroll=1
" Show mode and command
set showmode
set showcmd

set number " line numbers
set title " allow setting window title
set nohlsearch " don't keep search highlights after search
set incsearch " incremental search

" Limit line-length to 80 columns by highlighting col 81 onward
if exists("+colorcolumn")
    set colorcolumn=81
endif

