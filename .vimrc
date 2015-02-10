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

" Highlight current line (only in GUI - it slows down OS X terminal)
if has("gui_running")
    set cursorline 
end

" Allow switching out of a buffer with unsaved changes
set hidden

" Somewhat strangely, it seems that vim 7.3 has internal version number 703. 
" Look into using exists(":relativenumber") instead.
if version >= 703
    if has("gui_running") " really slows down OS X terminal
        set relativenumber "displayed line numbering will be relative to the current line
    end
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
    set guifont=Menlo\ Regular:h11
end

" Edit .vimrc easily
if !exists(':Vrc')
    command Vrc e ~/.vimrc
end

" Set up path so we can find header files
" clang -v is good for seeing the default search paths
if has ('macunix')
    autocmd FileType c,cpp,objc,objcpp setlocal path+=/System/Library/Frameworks,/Library/Frameworks
endif

autocmd FileType cpp setlocal path+=/usr/include/c++/4.2.1

let g:rubycomplete_buffer_loading=1
let g:rubycomplete_classes_in_global=1
" make <c-x><c-u> do omnicompletion for ruby
autocmd FileType ruby set completefunc=rubycomplete#Complete

" --- Keyboard mappings ---

function! g:OpenInXcode()
   call system("open -a Xcode ". shellescape(expand('%')))
endfunction

" Make it easy to close the window
map <leader>c <C-w>c
" :ListMethods comes with cocoa.vim
autocmd FileType objc,objcpp map <buffer> <leader>l :ListMethods<CR> 
" Open current file in Xcode
if has('macunix')
    map <leader>xc :call g:OpenInXcode()<CR> 
endif

" Align current Objective-C line using objc_align
" I'm sure there's a way to do this without the use of exec, but I don't know
" what it is
let s:objcAlignCommand = $HOME . '/code/objc_align/cmdline.rb'
if filereadable(s:objcAlignCommand)
    let s:objcAlignMapping = 'autocmd FileType objc map <buffer> <silent> <leader>al !!' . s:objcAlignCommand . '<CR>'
    exec s:objcAlignMapping
endif

" g:ClangUpdateQuickFix() comes with clang_complete - makes it parse file and
" put errors in quickfix window (v. useful!)
autocmd FileType c,cpp,objc,objcpp map <buffer> <leader>q :call g:ClangUpdateQuickFix()<CR> 

map <leader>ctf :CommandTFlush<CR>

" Until I integrate it properly into inccomplete, use this to normalise
" framework include/imports; e.g. AVFoundation.framework/Headers/AVAsset.h ->
" AVFoundation/AVAsset.h
if has('macunix')
    autocmd FileType c,cpp,objc,objcpp map <buffer> <leader>ni :.s/\v\.framework\/Headers//<CR>
endif

" Handy for alternates.
map <leader>a :on<CR>:AV<CR><C-w><C-x> 

" --- External options ---
"  Should put guards around these to check whether the things are defined.

" These need to come before a.vim is loaded
let g:alternateExtensions_h = "c,cpp,cxx,cc,CC,m,mm"
let g:alternateExtensions_m = "h"

let g:clang_complete_auto=0
let g:clang_complete_copen=1
let g:clang_snippets=1
let g:clang_complete_macros=1
let g:clang_case_insensitive=1

" This is an unfortunate compromise - I don't want to use the path or clang
" options when doing iOS development, because it completely screws things up.
" However, it would be nice to be able to alter this on a per-buffer basis,
" since I've now effectively broken standard C/C++ development.  Might
" investigate getopts#{anything}#getopts as mentioned in docs for doing
" something like this.
let g:clang_auto_user_options='.clang_complete'

if has("python")
    let g:clang_use_library=1
    let g:clang_library_path= "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/lib/"
endif

" This works well for clang_complete but I have a suspicion it might break
" other stuff. Should probably set <c-x><c-p> as a backup (or do it based on
" filetype)
let g:SuperTabDefaultCompletionType="<c-x><c-u>"

let g:inccomplete_showdirs = 1
let g:inccomplete_addclosebracket = ""
let g:inccomplete_frameworks = 1

" Testing - want console vim to warn me like MacVim does when an open file
" changes externally
" TODO: Decide whether this is overkill in terms of disk access - InsertEnter
" and InsertLeave may suffice
set autoread
au CursorHold,CursorHoldI,CursorMoved,InsertEnter,InsertLeave * checktime

"-- Vundle stuff --

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle
Plugin 'gmarik/vundle'

" % on acid
Plugin 'matchit.zip' 
" Includes molokai
Plugin 'Colour-Sampler-Pack' 
Plugin 'surround.vim'
Plugin 'https://github.com/tpope/vim-rails'
Plugin 'ack.vim'
" :A alternates
Plugin 'a.vim' 
Plugin 'Command-T'

" not sure about whether i like these ones.
Plugin 'https://github.com/scrooloose/nerdcommenter'
Plugin 'https://github.com/ervandew/supertab'
Plugin 'https://github.com/scrooloose/nerdtree'

Plugin 'https://github.com/lawrence-forooghian/clang_complete.git', {'rev': 'personal'}
"Plugin 'https://github.com/Rip-Rip/clang_complete'
Plugin 'git://github.com/lawrence-forooghian/cocoa.vim.git'
Plugin 'https://github.com/lawrence-forooghian/inccomplete.git'
Plugin 'https://github.com/b4winckler/vim-objc'

Plugin 'https://github.com/qqshfox/objc_matchbracket'

Plugin 'https://github.com/tpope/vim-fugitive'

" the one that came with my vim is out of date - ran into an issue with
" indentation when there was a class definition below a constant regexp
Plugin 'https://github.com/vim-ruby/vim-ruby' 

call vundle#end()

if has("gui_running") || &t_Co >= 256
    set background=dark
    colorscheme solarized
endif

" This is getting annoying so comment it out for now, and try to find a less
" obnoxious way of being made aware of hard tab usage.
"if &t_Co > 2 || has("gui_running")
    "" Highlight hard tabs.
    "" Needs to come after molokai is loaded, else it will override the
    "" highlighting rule.
    "highlight ExtraWhitespace ctermbg=red guibg=red
    "match ExtraWhitespace /\t/
"endif

" vim:ft=vim
