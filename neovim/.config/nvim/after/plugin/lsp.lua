local lsp = require('lsp-zero')
local null_ls = require("null-ls")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'rust_analyzer',
  'lua_ls'
})

lsp.configure("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
})

lsp.setup()

local null_opts = lsp.build_options("null-ls", {})

null_ls.setup({
  on_attach = function(client, bufnr)
    null_opts.on_attach(client, bufnr)
  end,
  sources = {
    null_ls.builtins.diagnostics.eslint.with({
      only_local = "node_modules/.bin"
    }),
    null_ls.builtins.formatting.prettier.with({
      only_local = "node_modules/.bin"
    }),
  },
})

