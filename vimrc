" Amalgamation of settings lifted from, among others:
" https://github.com/csswizardry/dotfiles/blob/master/.vimrc
" http://www.reinteractive.net/posts/166-awesome-vim-plugins

filetype plugin indent on
execute pathogen#infect()


                              " Basic Settings "

syntax enable
set background=dark
set t_Co=256
let g:rehash256 = 1
colorscheme molokai

set nocompatible
set encoding=utf-8
set expandtab " Tabs are spaces.
set shiftwidth=4 " Tab width 4 for a variety of situations.
set tabstop=4
set softtabstop=4
set shiftround " Round indents to nearest multiple of 4
if exists("+colorcolumn")
    set colorcolumn=81 " 80 char line guide
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
set list listchars=trail:+ " show trailing whitespace as +

set fillchars+=vert:\ " Remove | in splits (trailing whitespace significant)
set laststatus=2 " status line always visible (good for airline plugin).


                              " Unite Settings "

call unite#filters#matcher_default#use(['matcher_glob'])
call unite#filters#sorter_default#use(['sorter_rank'])
call unite#custom#source('file_rec/async','sorters','sorter_rank')
let g:unite_source_file_rec_max_cache_files = 0
call unite#custom#source('file_mru,file_rec,file_rec/async,grepocate',
            \ 'max_candidates', 0)
let g:unite_source_rec_async_command='ag --nocolor --nogroup --ignore ".hg"
            \ --ignore ".svn" --ignore ".git" --ignore ".bzr" --hidden -g ""'


                             " Airline Settings "

let g:airline_powerline_fonts = 1


                               " Key bindings "

nnoremap <silent> <C-p> :Unite -start-insert -buffer-name=files -winheight=10
            \ file_rec/async<cr>
nnoremap <Leader>b :Unite -buffer-name=Buffers -winheight=10 buffer<cr>
nnoremap <Leader>n :NERDTreeToggle<cr>
nnoremap <silent> <Leader>cw :%s/\s\+$// <bar> ''<cr> " remove trailing \s
