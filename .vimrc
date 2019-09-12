" ** .vimrc (Lawrence Forooghian)
" ** This is based on the example file that ships with Vim.

" Use Vim settings, rather than Vi settings (needs to come first)
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

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

" --- Copied settings ---

" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest
" Limit popup menu height
set pumheight=30

" --- Personal settings ---

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

set relativenumber

" Set last window to always have a status line
set laststatus=2

" Highlight the last used search pattern.
set hlsearch

" --- Keyboard mappings ---

" Make it easy to close the window
map <leader>cx <C-w>c

" Handy for alternates.
map <leader>a :on<CR>:AV<CR><C-w><C-x> 

map <leader>ul :TestLast<CR>
map <leader>un :TestNearest<CR>
map <leader>uf :TestFile<CR>
map <leader>us :TestSuite<CR>

nnoremap <Leader>ev :vsplit $MYVIMRC<cr>

nnoremap <silent> <leader>b :CommandTMRU<CR>
nnoremap <silent> <leader>p :CommandTTag<CR>

nnoremap <Leader>ns :nohlsearch<cr>
nnoremap <Leader>nt :NERDTreeToggle<cr>
nnoremap <Leader>nf :NERDTreeFind<cr>

nnoremap <Leader>g :Ack<cr>

inoremap jk <esc>
cnoremap jk <esc>
inoremap <c-[> <nop>

" --- External options ---

let g:NERDTreeShowLineNumbers=1

" Testing - want console vim to warn me like MacVim does when an open file
" changes externally
" TODO: Decide whether this is overkill in terms of disk access - InsertEnter
" and InsertLeave may suffice
set autoread
autocmd CursorHold,CursorHoldI,CursorMoved,InsertEnter,InsertLeave * checktime

let g:CommandTFileScanner = "find"
let g:CommandTMaxFiles = 500000

let g:airline#extensions#branch#enabled = 0

" make test commands execute using terminal - TODO restore to dispatch
let test#strategy = "vimterminal"

let g:ack_use_dispatch = 1

" tmux is no good because it causes a zoomed vim pane to become unzoomed
let g:dispatch_no_tmux_make = 1
let g:dispatch_no_tmux_start = 1
" job would be ideal but :Ack just seems to fail, so until that's fixed use
" iTerm
let g:dispatch_no_job_make = 1
let g:dispatch_no_job_start = 1

" invoke with '-'
nmap  -  <Plug>(choosewin)
" if you want to use overlay feature
let g:choosewin_overlay_enable = 1

let test#ruby#rspec#executable = 'bin/dspec'

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

augroup jira
    autocmd!
    autocmd BufRead *.jira :set filetype=confluencewiki
augroup END

" --- JSON syntax highlighting issue ---
" https://github.com/chriskempson/base16-vim/issues/125
augroup json
    autocmd!
    autocmd FileType json :highlight clear Error
augroup END

"--- Vundle stuff --

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle
Plugin 'VundleVim/Vundle.vim'

" Theme
Plugin 'chriskempson/base16-vim'

" General editing
Plugin 'matchit.zip' 
Plugin 'surround.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-sleuth' " apparently this infers indentation
Plugin 'tpope/vim-endwise' " inserts `end` for ruby

" Window navigation
Plugin 't9md/vim-choosewin'
Plugin 'weilbith/nerdtree_choosewin-plugin'

" File system navigation
Plugin 'scrooloose/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'a.vim' 
Plugin 'wincent/command-t'

" Info
Plugin 'vim-airline/vim-airline'

" Testing
Plugin 'janko-m/vim-test'

" Rails
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-dispatch'
Plugin 'rlue/vim-fold-rspec'

" iOS dev
Plugin 'keith/Swift.vim'

" Markdown
Plugin 'suan/vim-instant-markdown'

" Terraform
Plugin 'hashivim/vim-hashicorp-tools'

call vundle#end()

if filereadable(expand("~/.vimrc_background"))
    let base16colorspace=256
    source ~/.vimrc_background
endif

"if has("gui_running") || &t_Co >= 256
    "" https://github.com/chriskempson/base16-vim/issues/197#issuecomment-471507314
    "let base16colorspace=256
    "colorscheme base16-default-dark
"endif

filetype plugin indent on " Required by Vundle
syntax on
