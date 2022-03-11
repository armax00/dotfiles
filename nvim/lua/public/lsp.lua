require("common/lsp")

local servers = {
    clangd = { "--enable-config" },
    pyright = {},
    bashls = {},
    sumneko_lua = {
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      }
    },
}

for server, settings in pairs(servers) do
  Lsp.register_server(server, settings)
end
