-- Icons for Lualine and more.
local devicons = require"nvim-web-devicons"
devicons.setup({ default = true })

-- FZF
vim.api.nvim_set_keymap('n', '<c-P>',
    "<cmd>lua require('fzf-lua').files()<CR>",
    { noremap = true, silent = true })

-- NVim Tree
require"nvim-tree".setup()
vim.api.nvim_set_keymap("n", "<leader>n", ":NvimTreeToggle<CR>", {})

-- Lua Line.
local lualine = require"lualine"
lualine.setup({options = { theme = "nightfox", }})

-- Color scheme
local nightfox = require('nightfox')
nightfox.setup({
    fox = "nightfox",
    transparent = true,
})
nightfox.load()
