require("utils")
require("os")

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local home_dir = os.getenv("HOME")
local modules = {
  "common/init",
  "public/init",
  "private/init"
}

for _, module in ipairs(modules) do
  local filepath = home_dir .. "/.config/nvim/lua/" .. module .. ".lua"
  if File.exists(filepath) then
    require(module)
  end
end
