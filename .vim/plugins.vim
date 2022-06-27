"--- vim-plug stuff --

call plug#begin()

" Theme
Plug 'chriskempson/base16-vim'

" Highlight currently-selected search term
Plug 'PeterRincker/vim-searchlight'

" General editing
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-sleuth' " apparently this infers indentation
Plug 'tpope/vim-endwise' " inserts `end` for ruby
Plug 'sbdchd/neoformat'

" Window navigation
Plug 't9md/vim-choosewin'
Plug 'weilbith/nerdtree_choosewin-plugin'

" File system navigation
Plug 'scrooloose/nerdtree'
Plug 'mileszs/ack.vim'
Plug 'vim-scripts/a.vim'
Plug 'wincent/command-t'

" Git
" I am using this for :Gbrowse
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'

" Info
Plug 'vim-airline/vim-airline'

" Testing
Plug 'janko-m/vim-test'

" Rails
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-dispatch'
Plug 'rlue/vim-fold-rspec'

" iOS dev
Plug 'keith/Swift.vim'

" JavaScript
Plug 'lepture/vim-jinja'
" https://www.vimfromscratch.com/articles/setting-up-vim-for-typescript
" TypeScript syntax (there’s apparently one built in to later Vim versions but
" maybe this is better…? 🤷)
Plug 'HerringtonDarkholme/yats.vim'
" For completion and also currently using this to automatically run Prettier
" after save of some files (these file types are configured in
" .vim/coc-settings.json)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Terraform
Plug 'hashivim/vim-hashicorp-tools'

" Nginx
Plug 'chr4/nginx.vim'

" TOML
Plug 'cespare/vim-toml'

" Kotlin
Plug 'udalov/kotlin-vim'

" Textile
Plug 'timcharper/textile.vim'

call plug#end()
