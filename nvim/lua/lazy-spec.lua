return {
    -- Theme
    {
      'chriskempson/base16-vim',
      -- https://github.com/chriskempson/base16-vim/pull/236 demonstrates how to defer setting the colorscheme until this plugin is installed:
      config = function()
        vim.cmd('source ~/.vim/choose_base16_colorscheme.vim')
      end
    },

    -- File system navigation
    { "preservim/nerdtree" },
    { "mileszs/ack.vim" },
    -- TODO currently the first time you invoke fzf it asks whether you want to install it; figure out how to reproduce fzf#install of vim
    { "junegunn/fzf" },
    -- Handy commands on top of the core fzf integration — e.g. for listing buffers, or doing git ls-files
    { "junegunn/fzf.vim" },

    -- Git
    -- I am using this for :GBrowse and :Ggrep
    { "tpope/vim-fugitive" },
    { "tpope/vim-rhubarb" },

    -- iOS dev
    -- I don’t know if there is a better thing that I can use, e.g. some treesitter thing
    -- Not sure why it keeps putting test macro invocations at start of line
    { "keith/Swift.vim" }
}
