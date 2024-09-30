-- # Copied settings

-- Complete options (disable preview scratch window)
vim.opt.completeopt = { "menu", "menuone", "longest" }
-- Limit popup menu height
vim.opt.pumheight = 30

-- # Personal settings

-- ## Built-in vim options

-- ### Tabbing options

-- These options and the explained interactions are correct as long as we use
-- exclusively soft tabs. It sounds like it gets more complicated when we want
-- to use hard tabs.

-- I'm not sure what 'indent' means in the context of vim, but I don't think
-- it's the same as tabbing - I think indent is more to do with figuring out
-- the rules for tiering of indentation for a given language.

-- tabstop is the number of characters that a hard tab character is DISPLAYED
-- as.
vim.opt.tabstop = 4

-- These numbers seem like a sensible balance for C-esque languages (and they
-- also seem to be the Xcode defaults).

-- insert softtabstop number of spaces when TAB key is pressed
vim.opt.expandtab = true
-- is also used by the backspace key
vim.opt.softtabstop=4
-- The number of spaces used by << and =/==
vim.opt.shiftwidth=4

-- Use Ruby conventions.
-- It sounds like there's the option of putting a ruby.vim in
-- ~/.vim/after/ftplugin, but for now I like having everything in one file.
vim.api.nvim_create_autocmd("FileType", {
    pattern = "ruby",
    callback = function ()
        vim.opt_local.expandtab = true
        vim.opt_local.softtabstop = 2
        vim.opt_local.shiftwidth = 2
    end
})

vim.api.nvim_create_autocmd("FileType", {
    pattern = "java",
    callback = function ()
        vim.opt_local.expandtab = false
    end
})

-- ## Miscellaneous options

vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Ignore case when searching...
vim.opt.ignorecase = true
-- as long as the search string only contains lower case characters.
vim.opt.smartcase = true

-- Highlight current line
vim.opt.cursorline = true

-- This uses relative line numbers but shows the current line number instead of
-- 0.
vim.opt.relativenumber = true
vim.opt.number = true

-- Open files with all folds open (looking at you, RSpec plugin):
-- https://vi.stackexchange.com/questions/4482/how-to-open-a-file-with-all-folds-opened
vim.opt.foldenable = false

-- allow backspacing over everything in insert mode; this was in a default
-- .vimrc; upon removing it I wished I hadn't
vim.opt.backspace = { "indent", "eol", "start" }

-- ## Keyboard mappings

-- Make it easy to close the window
vim.keymap.set("", "<Leader>cx", function ()
    vim.cmd.close()
end)

-- Use git ls-files. Of the list of commands that fzf.vim provides, I think
-- this gives what I want — allows me to access important hidden files e.g.
-- .github/workflows (which :Files doesn’t), whilst excluding .gitignore stuff
-- like node_modules.
vim.keymap.set("n", "<Leader>t", function ()
    vim.cmd.GitFiles()
end)
vim.keymap.set("n", "<Leader>b", function ()
    vim.cmd.Buffers()
end)

vim.keymap.set("n", "<Leader>ns", function ()
    vim.cmd.nohlsearch()
end)
vim.keymap.set("n", "<Leader>nt", function ()
    vim.cmd.NERDTreeToggle()
end)
vim.keymap.set("n", "<Leader>nf", function ()
    vim.cmd.NERDTreeFind()
end)

vim.keymap.set("n", "<Leader>g", function ()
    vim.cmd.Ack()
end)

vim.keymap.set({ "i", "c" }, "jk", "<Esc>")
vim.keymap.set("i", "<C-[>", "")

-- ## Actions

-- Testing - want console vim to warn me like MacVim does when an open file
-- changes externally
-- TODO: Decide whether this is overkill in terms of disk access - InsertEnter
-- and InsertLeave may suffice
-- TODO find vim way of doingthis
vim.cmd("set autoread")
vim.cmd("autocmd CursorHold,CursorHoldI,CursorMoved,InsertEnter,InsertLeave * checktime")

-- ## External options

vim.g.NERDTreeShowLineNumbers = 1
vim.g.NERDTreeShowHidden = 1
-- Ignore the same 'junk' files as global.gitignore (not sure if there’s an
-- easy way to DRY this, since they use different syntax)
vim.g.NERDTreeIgnore = { [[\.sw\w$]], '.DS_Store' }

-- term=bold doesn’t seem to do anything, cterm=bold does
-- TODO find the nvim-y way to do this
-- Not even sure if this is doing anything
vim.cmd("highlight SelectedSearchResult term=bold cterm=bold ctermfg=DarkBlue ctermbg=LightMagenta guifg=#80a0ff gui=bold")
vim.cmd("highlight link Searchlight SelectedSearchResult")

-- Load package manager
require("config.lazy")
