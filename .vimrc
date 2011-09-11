" ** .vimrc (Lawrence Forooghian)
" ** This is based on the example file that ships with Vim.

" Use Vim settings, rather than Vi settings (needs to come first)
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" Only do this part when compiled with support for autocommands.
if has("autocmd")

    " Enable file type detection.
    " Use the default filetype settings, so that mail gets 'tw' set to 72,
    " 'cindent' is on in C files, etc.
    " Also load indent files, to automatically do language-dependent indenting.
    filetype plugin indent on

    " Put these in an autocmd group, so that we can delete them easily.
    augroup vimrcEx
        au!

        " For all text files set 'textwidth' to 78 characters.
        autocmd FileType text setlocal textwidth=78

        " When editing a file, always jump to the last known cursor position.
        " Don't do it when the position is invalid or when inside an event handler
        " (happens when dropping a file on gvim).
        " Also don't do it when the mark is in the first line, that is the default
        " position when opening a file.
        autocmd BufReadPost *
                    \ if line("'\"") > 1 && line("'\"") <= line("$") |
                    \   exe "normal! g`\"" |
                    \ endif

    augroup END

else

    set autoindent " always set autoindenting on

endif " has("autocmd")

"
" ---- Personal settings ----
"

" Some things have been moved down from the example section now that I know
" what they do.

" I should aim to understand all of the stuff above this, so that I can pick
" which bits are important to me.

" --- Built-in vim options ---

" -- Tabbing options --

" These options and the explained interactions are correct as long as we use
" exclusively soft tabs. It sounds like it gets more complicated when we want
" to use hard tabs.

" I'm not sure what 'indent' means in the context of vim, but I don't think
" it's the same as tabbing - I think indent is more to do with figuring out
" the rules for tiering of indentation for a given language.

" tabstop is the number of characters that a hard tab character is DISPLAYED
" as.
set tabstop=4

" These numbers seem like a sensible balance for C-esque languages (and they
" also seem to be the Xcode defaults).

" Always insert softtabstop number of spaces when TAB key is pressed
set expandtab 
" softtabstop is also used by the backspace key
set softtabstop=4
" The number of spaces used by << and =/==
set shiftwidth=4

" Use Ruby conventions.
" It sounds like there's the option of putting a ruby.vim in
" ~/.vim/after/ftplugin, but for now I like having everything in one file.
autocmd FileType ruby setlocal expandtab softtabstop=2 shiftwidth=2

" Make it easy to see when a file is using hard tabs.
set listchars=tab:>!
set list

" -- Miscellaneous options --

set ruler " show the cursor position all the time
set history=50 " keep 50 lines of command line history
set showcmd " display incomplete commands
set incsearch " do incremental searching

" Ignore case when searching...
set ignorecase 
" as long as the search string only contains lower case characters.
set smartcase 

" Cool tab completion for commands
set wildmenu 

" Highlight current line
set cursorline 

" Somewhat strangely, it seems that vim 7.3 has internal version number 703. 
" Look into using exists(":relativenumber") instead.
if version >= 703
    set relativenumber "displayed line numbering will be relative to the current line
else
    set number " show line numbers
end

if &t_Co > 2 || has("gui_running")
    " Switch syntax highlighting on, when the terminal has colours.
    syntax on
    " Also switch on highlighting the last used search pattern.
    set hlsearch
endif

" Trying to move away from having a separate .gvimrc file, so here are the GUI
" options with a guard
if has("gui_running")
    set guioptions-=T
    set visualbell
    set guifont=Monaco:h12
end

" Disable mouse (including wheel)
if has('mouse')
    set mouse=""
    map <ScrollWheelUp> <Nop>
    map <ScrollWheelDown> <Nop>
end

" Edit .vimrc easily
command Vrc e ~/.vimrc

" TODO: command for generating ctags

" --- External options ---
"  Should put guards around these to check whether the things are defined.

map <leader>n :NERDTree<CR>
map <leader>l :TlistToggle<CR>

"-- Vundle stuff --

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Bundle 'gmarik/vundle'

" Allow plugins to use .
Bundle 'repeat.vim' 
" % on acid
Bundle 'matchit.zip' 
" Includes molokai
Bundle 'Color-Sampler-Pack' 
Bundle 'surround.vim'
Bundle 'rails.vim'
Bundle 'ack.vim'
" :A alternates
Bundle 'a.vim' 
Bundle 'Command-T'

" not sure about whether i like these ones.
Bundle 'https://github.com/scrooloose/syntastic/'
Bundle 'git://github.com/lawrence-forooghian/cocoa.vim.git'
"Bundle 'taglist.vim'
Bundle 'git://github.com/altercation/vim-colors-solarized.git'
"Bundle 'git://github.com/pangloss/vim-javascript.git'
"Bundle 'jslint.vim'
Bundle 'https://github.com/Raimondi/delimitMate'
Bundle 'fugitive.vim'
Bundle 'nerdtree.vim'

let g:syntastic_enable_signs=1
let delimitMate_expand_cr = 1
let delimitMate_expand_space = 1
let Tlist_Ctags_Cmd='/opt/local/var/macports/software/ctags/5.8_0/opt/local/bin/ctags' 

" If the filetype is obj-c, :A should use the alternate functionality provided
" by cocoa.vim. Not really sure if this is the 'right' way to go about this
" but it seems to do the job.
" (The bang means 'redefine if it already exists'; else we get warnings upon
" switching back to a buffer, and the '-buffer' means 'make the command local
" to this buffer')
" It's worth seeing if we can get a.vim to do this for us.
autocmd FileType objc command! -buffer A norm <leader>A

if has("gui_running")
    colorscheme molokai
endif

if &t_Co > 2 || has("gui_running")
    " Highlight hard tabs.
    " Needs to come after molokai is loaded, else it will override the
    " highlighting rule.
    highlight ExtraWhitespace ctermbg=red guibg=red
    match ExtraWhitespace /\t/
endif
