return {
    -- Theme
    {
      'chriskempson/base16-vim',
      -- https://github.com/chriskempson/base16-vim/pull/236 demonstrates how to defer setting the colorscheme until this plugin is installed:
      config = function()
        vim.cmd('source ~/.vim/choose_base16_colorscheme.vim')
      end
    },

    -- Highlight currently-selected search term
    { 'PeterRincker/vim-searchlight' },

    -- General editing
    { 'tpope/vim-surround' },
    { 'scrooloose/nerdcommenter' },
    -- sleuth turned off because its .editorconfig handling is interfering with my Git commit textwidth; see comment in nvim/init.lua
    --{ 'tpope/vim-sleuth' }, -- apparently this infers indentation
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
    {
      "daliusd/ghlite.nvim",
      opts = {},
      keys = {
        -- Open the diff for the current PR to review changes
        { '<leader>prd', '<cmd>GHLitePRDiff<cr>', desc = 'PR diff' },
        -- Leave a review comment on the line under the cursor (or visual selection) in a diff
        { '<leader>prc', '<cmd>GHLitePRAddComment<cr>', desc = 'PR comment' },
        { '<leader>prc', '<cmd>GHLitePRAddComment<cr>', mode = 'v', desc = 'PR comment' },
      },
    },

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
    -- I don't know if there is a better thing that I can use, e.g. some treesitter thing
    -- Not sure why it keeps putting test macro invocations at start of line
    { "keith/Swift.vim" },

    -- JavaScript
    { 'lepture/vim-jinja' },
    -- https://www.vimfromscratch.com/articles/setting-up-vim-for-typescript
    -- TypeScript syntax (there's apparently one built in to later Vim versions but
    -- maybe this is better…? 🤷)
    { 'HerringtonDarkholme/yats.vim' },
    -- Completion
    {
      'saghen/blink.cmp',
      version = '1.*',
      opts = {
        keymap = {
          preset = 'none',
          ['<Tab>'] = { 'select_next', 'fallback' },
          ['<S-Tab>'] = { 'select_prev', 'fallback' },
          ['<CR>'] = { 'accept', 'fallback' },
          ['<C-Space>'] = { 'show' },
          ['<C-e>'] = { 'cancel', 'fallback' },
        },
        completion = {
          documentation = { auto_show = true },
        },
        sources = {
          default = { 'lsp', 'path' },
        },
      },
    },

    -- LSP server management
    {
      'williamboman/mason.nvim',
      opts = {},
    },
    {
      'williamboman/mason-lspconfig.nvim',
      opts = {
        ensure_installed = { 'ts_ls' },
        automatic_installation = true,
      },
    },

    -- LSP configuration
    {
      'neovim/nvim-lspconfig',
      dependencies = { 'saghen/blink.cmp', 'williamboman/mason-lspconfig.nvim' },
      config = function()
        local capabilities = require('blink.cmp').get_lsp_capabilities()

        -- TypeScript — installed and managed by mason
        vim.lsp.config('ts_ls', { capabilities = capabilities })
        vim.lsp.enable('ts_ls')

        -- Swift/ObjC/C/C++ — uses system binary from Xcode (not managed by mason)
        vim.lsp.config('sourcekit', {
          capabilities = capabilities,
          cmd = { vim.fn.trim(vim.fn.system('xcrun --find sourcekit-lsp')) },
        })
        vim.lsp.enable('sourcekit')

        -- Keybindings (set on LspAttach so they only apply in LSP-enabled buffers)
        vim.api.nvim_create_autocmd('LspAttach', {
          callback = function(args)
            local buf = args.buf
            local map = function(mode, lhs, rhs, desc)
              vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
            end

            map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
            map('n', 'gy', vim.lsp.buf.type_definition, 'Go to type definition')
            map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')  -- Neovim 0.11: gri
            map('n', 'gr', vim.lsp.buf.references, 'List references')  -- Neovim 0.11: grr
            map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')  -- Neovim 0.11: K
            map('n', '[g', vim.diagnostic.goto_prev, 'Previous diagnostic')  -- Neovim 0.11: [d
            map('n', ']g', vim.diagnostic.goto_next, 'Next diagnostic')  -- Neovim 0.11: ]d
            map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename symbol')  -- Neovim 0.11: grn
            map({'n', 'x'}, '<leader>a', vim.lsp.buf.code_action, 'Code action')  -- Neovim 0.11: gra
            map('n', '<leader>qf', function()
              vim.lsp.buf.code_action({ context = { only = { 'quickfix' }, diagnostics = {} }, apply = true })
            end, 'Preferred quickfix')
            map('n', '<space>o', vim.lsp.buf.document_symbol, 'Document symbols')  -- Neovim 0.11: gO
            map('n', '<space>s', vim.lsp.buf.workspace_symbol, 'Workspace symbols')
            map('n', '<space>a', vim.diagnostic.setloclist, 'Diagnostics list')

            -- Highlight symbol under cursor on CursorHold
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            if client and client.supports_method('textDocument/documentHighlight') then
              local highlight_group = vim.api.nvim_create_augroup('lsp_highlight_' .. buf, { clear = true })
              vim.api.nvim_create_autocmd('CursorHold', {
                group = highlight_group,
                buffer = buf,
                callback = vim.lsp.buf.document_highlight,
              })
              vim.api.nvim_create_autocmd('CursorMoved', {
                group = highlight_group,
                buffer = buf,
                callback = vim.lsp.buf.clear_references,
              })
            end
          end,
        })

        -- :Format — format current buffer
        vim.api.nvim_create_user_command('Format', function()
          vim.lsp.buf.format()
        end, { desc = 'Format current buffer via LSP' })

        -- :OR — organise imports
        vim.api.nvim_create_user_command('OR', function()
          vim.lsp.buf.code_action({ context = { only = { 'source.organizeImports' }, diagnostics = {} }, apply = true })
        end, { desc = 'Organise imports via LSP' })
      end,
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
