function require_if(module)
  local filepath = vim.fn.stdpath('config') .. "/lua/" .. module .. ".lua"
  if vim.loop.fs_stat(filepath) then
    require(module)
  end
end
