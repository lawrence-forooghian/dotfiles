" Config only for vim (not nvim)

" -- Settings that only exist in Vim or which are enabled by default in nvim --

" Use Vim settings, rather than Vi settings (needs to come first)
set nocompatible

set ruler " show the cursor position all the time
set history=50 " keep 50 lines of command line history
set showcmd " display incomplete commands
set incsearch " do incremental searching

" Cool tab completion for commands
set wildmenu 

" Allow switching out of a buffer with unsaved changes
set hidden

" Set last window to always have a status line
set laststatus=2

" Highlight the last used search pattern.
set hlsearch
