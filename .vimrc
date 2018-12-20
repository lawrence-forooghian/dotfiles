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
" ---- Copied settings ----
"

" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest
" Limit popup menu height
set pumheight=30

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

autocmd FileType java setlocal noexpandtab

" Make it easy to see when a file is using hard tabs.
set listchars=tab:>!
"set list

" -- Miscellaneous options --

let mapleader=","
let maplocalleader="-"

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

" Allow switching out of a buffer with unsaved changes
set hidden

set number
set relativenumber

" Set last window to always have a status line
set laststatus=2

if &t_Co > 2 || has("gui_running")
    " Switch syntax highlighting on, when the terminal has colours.
    " Also switch on highlighting the last used search pattern.
    set hlsearch
endif

" Trying to move away from having a separate .gvimrc file, so here are the GUI
" options with a guard
if has("gui_running")
    set guioptions-=T
    set visualbell
    set guifont=Menlo\ Regular:h15
end

" --- Keyboard mappings ---

function! g:OpenInXcode()
   call system("open -a Xcode ". shellescape(expand('%')))
endfunction

" Make it easy to close the window
map <leader>cx <C-w>c
" :ListMethods comes with cocoa.vim
autocmd FileType objc,objcpp map <buffer> <leader>l :ListMethods<CR> 

map <leader>ctf :CommandTFlush<CR>

" Handy for alternates.
map <leader>a :on<CR>:AV<CR><C-w><C-x> 

map <leader>ul :TestLast<CR>
map <leader>un :TestNearest<CR>
map <leader>uf :TestFile<CR>
map <leader>us :TestSuite<CR>

nnoremap <Leader>ev :vsplit $MYVIMRC<cr>

nnoremap <silent> <leader>b :CommandTMRU<CR>

nnoremap <Leader>ns :nohlsearch<cr>
nnoremap <Leader>nt :NERDTreeToggle<cr>

inoremap jk <esc>
cnoremap jk <esc>
inoremap <c-[> <nop>

" --- External options ---
"  Should put guards around these to check whether the things are defined.

" These need to come before a.vim is loaded
let g:alternateExtensions_h = "c,cpp,cxx,cc,CC,m,mm"
let g:alternateExtensions_m = "h"

let g:NERDTreeShowLineNumbers=1

" Testing - want console vim to warn me like MacVim does when an open file
" changes externally
" TODO: Decide whether this is overkill in terms of disk access - InsertEnter
" and InsertLeave may suffice
set autoread
autocmd CursorHold,CursorHoldI,CursorMoved,InsertEnter,InsertLeave * checktime

let g:CommandTFileScanner = "watchman"

let g:airline#extensions#branch#enabled = 0

" --- Filetypes for some common iOS files ---

augroup stringsdict
    autocmd!
    autocmd BufRead *.stringsdict :set filetype=xml
augroup END

augroup fastlane
    autocmd!
    autocmd BufRead Appfile :set filetype=ruby
    autocmd BufRead Fastfile :set filetype=ruby
    autocmd BufRead Matchfile :set filetype=ruby
    autocmd BufRead Pluginfile :set filetype=ruby
    autocmd BufRead Snapfile :set filetype=ruby
    autocmd BufRead Scanfile :set filetype=ruby
augroup END

augroup cocoapods
    autocmd!
    autocmd BufRead Podfile :set filetype=ruby
augroup END

augroup danger
    autocmd!
    autocmd BufRead Dangerfile :set filetype=ruby
augroup END

"-- Vundle stuff --

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Theme
Plugin 'chriskempson/base16-vim'

" General editing
Plugin 'matchit.zip' 
Plugin 'surround.vim'
Plugin 'https://github.com/scrooloose/nerdcommenter'
Plugin 'https://github.com/tpope/vim-sleuth' " apparently this infers indentation

" File system navigation
Plugin 'https://github.com/scrooloose/nerdtree'
Plugin 'ack.vim'
Plugin 'a.vim' 
Plugin 'https://github.com/wincent/command-t'

" Info
Plugin 'vim-airline/vim-airline'

" Git
Plugin 'https://github.com/tpope/vim-fugitive'
Plugin 'https://github.com/airblade/vim-gitgutter'

" Rails
Plugin 'https://github.com/tpope/vim-rails'
Plugin 'https://github.com/tpope/vim-dispatch'

" iOS dev
Plugin 'git://github.com/lawrence-forooghian/cocoa.vim.git'
Plugin 'https://github.com/b4winckler/vim-objc'
Plugin 'https://github.com/qqshfox/objc_matchbracket'
Plugin 'https://github.com/keith/Swift.vim'

" Testing
Plugin 'janko-m/vim-test'

" Markdown
Plugin 'https://github.com/suan/vim-instant-markdown'

call vundle#end()

if has("gui_running") || &t_Co >= 256
    let base16colorspace=256
    colorscheme base16-default-dark
endif

filetype plugin indent on " Required by Vundle
syntax on

