local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  "tsserver",
  "lua_ls",
})

lsp.configure("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
    },
  },
})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })

  -- Disable tsserver formatting as it conflicts with prettier.
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
end)

lsp.setup()
