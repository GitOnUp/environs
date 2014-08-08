" A great deal of this is lifted from csswizardry's excellent .vimrc file:
" https://github.com/csswizardry/dotfiles/blob/master/.vimrc
" Thanks to him for providing the final push for me to learn it.

filetype plugin indent on
syntax on

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

" Remove |'s on vertical splits
:set fillchars+=vert:\ " Whitespace at end is significant

" Plugin-specific bindings follow.
execute pathogen#infect()

" Pretty colors
" These need to be after the pathogen#infect call since the scheme is installed
" via pathogen.
syntax enable
set background=dark
set t_Co=256
let g:rehash256 = 1
colorscheme molokai

" credit to reInteractive for the following bindings
" http://www.reinteractive.net/posts/166-awesome-vim-plugins

" \b does open buffers
nnoremap <Leader>b :Unite -buffer-name=Buffers -winheight=10 buffer<cr>
" \n does NERDTree
noremap <Leader>n :NERDTreeToggle<cr>
" \f does open buffers followed by file tree
nnoremap <leader>f :Unite -buffer-name=Files -winheight=10 buffer file<cr>

set laststatus=2 " status line always visible (good for airline plugin).

" CtrlP-like search
call unite#filters#matcher_default#use(['matcher_glob'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/async','sorters','sorter_rank')
let g:unite_source_file_rec_max_cache_files = 0
call unite#custom#source('file_mru,file_rec,file_rec/async,grepocate', 'max_candidates', 0)
let g:unite_source_rec_async_command='ag --nocolor --nogroup --ignore ".hg" --ignore ".svn" --ignore ".git" --ignore ".bzr" --hidden -g ""'
" replacing ctrl-p with Unite
nnoremap <silent> <C-p> :Unite -start-insert -buffer-name=files -winheight=10 file_rec/async<cr>

let g:airline_powerline_fonts = 1
