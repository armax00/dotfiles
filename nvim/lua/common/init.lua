-- Setj<space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

require('common/plugins')
require('common/plugins_setup')
require('common/mappings')

-- [[ Setting options ]]
vim.o.hlsearch = true
vim.o.termguicolors = true
vim.o.colorcolumn = "81,101"

-- Numbering
vim.wo.number = true
vim.wo.relativenumber = true

-- Mouse integration
vim.o.mouse = 'v'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Tabs
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true

-- [[ Highlighting on yank ]]

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Remove trailing spaces on save ]]

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})
