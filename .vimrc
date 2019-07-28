" All system-wide defaults are set in $VIMRUNTIME/debian.vim and sourced by
" the call to :runtime you can find below.  If you wish to change any of those
" settings, you should do it in this file (/etc/vim/vimrc), since debian.vim
" will be overwritten everytime an upgrade of the vim packages is performed.
" It is recommended to make changes after sourcing debian.vim since it alters
" the value of the 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Vim will load $VIMRUNTIME/defaults.vim if the user does not have a vimrc.
" This happens after /etc/vim/vimrc(.local) are loaded, so it will override
" any settings in these files.
" If you don't want that to happen, uncomment the below line to prevent
" defaults.vim from being loaded.
" let g:skip_defaults_vim = 1

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible

" Vim5 and later versions support syntax highlighting. Uncommenting the next
" line enables syntax highlighting by default.
if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
"if has("autocmd")
"  filetype plugin indent on
"endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
"set showmatch		" Show matching brackets.
"set ignorecase		" Do case insensitive matching
"set smartcase		" Do smart case matching
"set incsearch		" Incremental search
"set autowrite		" Automatically save before commands like :next and :make
"set hidden		" Hide buffers when they are abandoned
"set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif


" Base settings -----------------------------------------------------------------------------------
set nocompatible           " use Vim settings, rather then Vi settings
syntax on                  " turn on syntax highlighting (this will turn 'filetype on' by default)
filetype plugin indent on  " turn on file type detection
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
