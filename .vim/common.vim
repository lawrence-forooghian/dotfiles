" Config for vim and nvim.

" --- Copied settings ---

" Complete options (disable preview scratch window)
set completeopt=menu,menuone,longest
" Limit popup menu height
set pumheight=30

" --- Personal settings ---

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

" Ignore case when searching...
set ignorecase 
" as long as the search string only contains lower case characters.
set smartcase 

" Highlight current line
set cursorline 

" This uses relative line numbers but shows the current line number instead of
" 0.
set relativenumber
set number

" Open files with all folds open (looking at you, RSpec plugin):
" https://vi.stackexchange.com/questions/4482/how-to-open-a-file-with-all-folds-opened
set nofoldenable

" allow backspacing over everything in insert mode; this was in a default
" .vimrc; upon removing it I wished I hadn't
set backspace=indent,eol,start

" --- Keyboard mappings ---

" Make it easy to close the window
map <leader>cx <C-w>c

" Use git ls-files. Of the list of commands that fzf.vim provides, I think
" this gives what I want — allows me to access important hidden files e.g.
" .github/workflows (which :Files doesn’t), whilst excluding .gitignore stuff
" like node_modules.
nnoremap <silent> <leader>t :GitFiles<CR>
nnoremap <silent> <leader>b :Buffers<CR>

nnoremap <Leader>ns :nohlsearch<cr>
nnoremap <Leader>nt :NERDTreeToggle<cr>
nnoremap <Leader>nf :NERDTreeFind<cr>

nnoremap <Leader>g :Ack<cr>

inoremap jk <esc>
cnoremap jk <esc>
inoremap <c-[> <nop>

" --- External options ---

let g:NERDTreeShowLineNumbers=1
let g:NERDTreeShowHidden=1
" Ignore the same 'junk' files as global.gitignore (not sure if there’s an
" easy way to DRY this, since they use different syntax)
let g:NERDTreeIgnore=['\.sw\w$', '.DS_Store']
