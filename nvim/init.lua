require("utils")
require("os")

local home_dir = os.getenv("HOME")
local modules = {
  "common/init",
  "public/init",
  "work/init"
}

for _, module in ipairs(modules) do
  local filepath = home_dir .. "/.config/nvim/lua/" .. module .. ".lua"
  if File.exists(filepath) then
    require(module)
  end
end
