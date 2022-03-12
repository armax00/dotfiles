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
local nightfox = require("nightfox")
nightfox.setup({
    fox = "nightfox",
    transparent = true,
})
nightfox.load()

-- Telescope
local function telescope_keymap(keys, cmd)
  vim.api.nvim_set_keymap("n", keys, cmd, {noremap=true, silent=true})
end
telescope_keymap(
    "<leader>ff", ":lua require('telescope.builtin').find_files()<cr>")
telescope_keymap(
    "<leader>fg", ":lua require('telescope.builtin').live_grep()<cr>")
telescope_keymap(
    "<leader>fb", ":lua require('telescope.builtin').buffers()<cr>")
telescope_keymap(
    "<leader>fh", "lua require('telescope.builtin').help_tags()<cr>")
