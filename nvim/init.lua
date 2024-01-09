local modules = {
  "common/init",
  "public/init",
  "private/init"
}

for _, module in ipairs(modules) do
  local filepath = vim.fn.stdpath('config') .. "/lua/" .. module .. ".lua"
  if vim.loop.fs_stat(filepath) then
    require(module)
  end
end
