set nocompatible           " use Vim settings, rather then Vi settings
syntax on                  " turn on syntax highlighting (this will turn 'filetype on' by default)
filetype off               " turn off file type detection

" Plugins by VundleVim ---------------------------------------------------------------------------
set rtp+=~/.vim/bundle/Vundle.vim " set the runtime path to include Vundle and initialize
call vundle#begin()               " call vundle#begin('~/some/path/here')
Plugin 'VundleVim/Vundle.vim'     " let Vundle manage Vundle, required
Plugin 'scrooloose/nerdtree'
Plugin 'fatih/vim-go'

call vundle#end()            " required
filetype plugin indent on  " turn on file type detection

" Base settings -----------------------------------------------------------------------------------
set hidden                 " the current buffer can be put to the background without writing it on disk
set nobackup               " do not create backup files
set noswapfile             " do not create swap files

" text and indentaion
" set nowrap                 " do not wrap long lines
" set textwidth=0            " disable break lonk lines while editing
" set fo-=t                  " disable automatic text wrapping
set autoindent             " copy indent from current line when starting a new line
set expandtab              " use spaces instead of tabs
set tabstop=4              " number of spaces that a <Tab> in the file counts for
set shiftwidth=4           " number of spaces to use for each step of (auto)indent
set softtabstop=4          " number of spaces that a <Tab> counts for while performing
set smarttab               " use different amount of spaces in a front of line or in other places
                           " according to 'tabstop', 'softtabstop' and 'shiftwidth' settings
set backspace=indent,eol,start  " allow backspacing over everything in insert mode
set encoding=utf-8              " sets the character encoding used inside Vim
set fileencodings=utf8,cp1251   " list of character encodings considered
                                " when starting to edit an existing file

set ignorecase                  " ignore case sensivity
set smartcase                   "
set omnifunc=syntaxcomplete#Complete    " code completion

" UI
set showcmd                " show (partial) command in the last line of the screen
set wildmenu               " turn on wildmenu (enhanced mode of command-line completion)
set wcm=<Tab>              " wildmenu navigation key
set laststatus=2           " always show the status line
set incsearch              " jump to search results while typing a search command
set ttyfast                " send more characters at a given time
set lazyredraw             " redraw only when we need to
set nonumber               " do not show line numbers
set nocursorline           " do not highlight the screen line of the cursor
set nofoldenable           " turn off folding
set scrolloff=3            " minimal number of screen lines to keep above and below the cursor
set splitright             " how to split new windows
set winminheight=0         " non-current windows may collapse to a status line and nothing else
set equalalways            " makes sure Vim try to make all windows equal

" invisible characters
set nolist                 " do not display unprintable characters by default
set listchars=tab:⇥\ ,space:·,trail:·,extends:⋯,precedes:⋯,eol:¬  " invisible symbols representation
execute pathogen#infect()
call pathogen#helptags()

" NERD Tree
map <C-n> :NERDTreeToggle<CR>

" split screen panels navigation
nnoremap <C-J> <C-W><C-J>   " switch on panel down
nnoremap <C-K> <C-W><C-K>   " switch on panel up
nnoremap <C-L> <C-W><C-L>   " switch on panel right
nnoremap <C-H> <C-W><C-H>   " switch on panel left

" close brackets
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

" go import on save
let g:go_fmt_command = "goimports"

" remap completion to ,,
let mapleader=","
inoremap <leader>, <C-x><C-o>
