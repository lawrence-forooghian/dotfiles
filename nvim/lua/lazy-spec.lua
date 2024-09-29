return {
    -- Theme
    {
      'chriskempson/base16-vim',
      -- https://github.com/chriskempson/base16-vim/pull/236 demonstrates how to defer setting the colorscheme until this plugin is installed:
      config = function()
        vim.cmd('source ~/.vim/choose_base16_colorscheme.vim')

        -- Fix indistinguishable CoC popup menu selection highlight, copied from
        -- https://github.com/neoclide/coc.nvim/wiki/F.A.Q#the-selection-highlight-does-not-look-good
        -- That comment suggests it might be an issue with the colour scheme I’m
        -- using 🤷
        -- TODO how to write this in a neovim-y way?
        vim.cmd("hi CocMenuSel ctermbg=237 guibg=#13354A")
        vim.cmd("autocmd ColorScheme * hi CocMenuSel ctermbg=237 guibg=#13354A")
      end
    },

    -- Highlight currently-selected search term
    { 'PeterRincker/vim-searchlight' },

    -- General editing
    { 'tpope/vim-surround' },
    { 'scrooloose/nerdcommenter' },
    { 'tpope/vim-sleuth' }, -- apparently this infers indentation
    { 'tpope/vim-endwise' }, -- inserts `end` for ruby
    { 'sbdchd/neoformat' },

    -- File system navigation
    { "preservim/nerdtree" },
    { "mileszs/ack.vim" },
    { "vim-scripts/a.vim" },
    -- TODO currently the first time you invoke fzf it asks whether you want to install it; figure out how to reproduce fzf#install of vim
    { "junegunn/fzf" },
    -- Handy commands on top of the core fzf integration — e.g. for listing buffers, or doing git ls-files
    { "junegunn/fzf.vim" },

    -- Git
    -- I am using this for :GBrowse and :Ggrep
    { "tpope/vim-fugitive" },
    { "tpope/vim-rhubarb" },

    -- Info
    { 'vim-airline/vim-airline' },

    -- Testing
    { 'janko-m/vim-test' },

    -- Rails
    { 'tpope/vim-projectionist' },
    { 'tpope/vim-rails' },
    { 'tpope/vim-rake' },
    { 'tpope/vim-dispatch' },
    { 'rlue/vim-fold-rspec' },

    -- iOS dev
    -- I don’t know if there is a better thing that I can use, e.g. some treesitter thing
    -- Not sure why it keeps putting test macro invocations at start of line
    { "keith/Swift.vim" },

    -- JavaScript
    { 'lepture/vim-jinja' },
    -- https://www.vimfromscratch.com/articles/setting-up-vim-for-typescript
    -- TypeScript syntax (there’s apparently one built in to later Vim versions but
    -- maybe this is better…? 🤷)
    { 'HerringtonDarkholme/yats.vim' },
    -- For completion and also currently using this to automatically run Prettier
    -- after save of some files (these file types are configured in
    -- .vim/coc-settings.json)
    { 'neoclide/coc.nvim', branch = 'release', config = function ()
        vim.cmd.runtime("coc_config.vim")
      end
    },

    -- Terraform
    { 'hashivim/vim-hashicorp-tools' },

    -- Nginx
    { 'chr4/nginx.vim' },

    -- TOML
    { 'cespare/vim-toml' },

    -- Kotlin
    { 'udalov/kotlin-vim' },

    -- Textile
    { 'timcharper/textile.vim' },

    -- Twig (templating language used by Kimai 2 for invoices)
    { 'nelsyeung/twig.vim' },
}
