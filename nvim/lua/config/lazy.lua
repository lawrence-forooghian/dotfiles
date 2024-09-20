-- Copied from https://lazy.folke.io/installation

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    -- TODO trying to understand what’s going on here — why did their example of putting it in a separate file not work? Probably need to understand Lua / nvim better to debug
  spec = {
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
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})
