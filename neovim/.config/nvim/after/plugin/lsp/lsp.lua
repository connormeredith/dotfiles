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

lsp.setup()
