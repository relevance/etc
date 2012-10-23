" Minimal viable Vim config

set nocompatible
syntax on
set background=dark
filetype plugin indent on

set visualbell

set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set autoindent

set laststatus=2
set statusline=\ "
set statusline+=%f\ " file name
set statusline+=[
set statusline+=%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&fileformat}] " file format

set statusline+=%h%1*%m%r%w%0* " flag
set statusline+=%= " right align
set statusline+=%-14.(%l,%c%V%)\ %<%P " offset

set number
setlocal numberwidth=3
set autoread

set wildmenu 
set wildmode=list:longest,full

set backspace=indent,eol,start

set nowrap

set nobackup                      " Don't make a backup before overwriting a file.
set nowritebackup                 " And again.
set noswapfile
set directory=$HOME/.vim/tmp//,.  " Keep swap files in one location
