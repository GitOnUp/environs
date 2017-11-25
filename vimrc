" BEGIN REQUIRED BY VUNDLE
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'chriskempson/vim-tomorrow-theme'

call vundle#end()
filetype plugin indent on
" END REQUIRED BY VUNDLE

syntax enable
set background=dark
set t_Co=256
colorscheme Tomorrow-Night-Bright

set guifont=DejaVu\ Sans\ Mono\ 10
set guioptions=egm
set nocompatible
set encoding=utf-8
set expandtab " Tabs are spaces.
set shiftwidth=4 " Tab width 4 for a variety of situations.
set tabstop=4
set softtabstop=4
set shiftround " Round indents to nearest multiple of 4
if exists("+colorcolumn")
    set colorcolumn=121 " 120 char line guide
endif

set scrolloff=3 " visibility on far side of cursor when scrolling
set sidescrolloff=5
set sidescroll=1 " Scroll sideways by characters
set nowrap

set showmode
set showcmd
set number " line numbers
set title " allow setting window title

set nohlsearch " don't keep search highlights after search
set incsearch " incremental search
set list listchars=tab:>-,trail:+ " show trailing whitespace as +

set fillchars+=vert:\ " Remove | in splits (trailing whitespace significant)
set laststatus=2 " status line always visible (good for airline plugin).

                              " Airline Settings "

let g:airline_powerline_fonts = 1

                               " Key bindings "

nnoremap <Leader>n :NERDTreeToggle<cr>
nnoremap <silent> <Leader>cw :%s/\s\+$// <bar> ''<cr> " remove trailing \s
