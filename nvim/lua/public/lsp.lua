require("common/lsp")

local servers = {
    clangd = { "--enable-config" },
    pyright = {},
    sumneko_lua = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    },
    bashls = {},
}

for server, settings in pairs(servers) do
  Lsp.register_server(server, settings)
end
