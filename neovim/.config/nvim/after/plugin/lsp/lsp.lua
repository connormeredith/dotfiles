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

  -- Diagnostic keymaps.
  vim.keymap.set("n", "<leader>vd", function()
    vim.diagnostic.open_float()
  end, { buffer = bufnr, remap = false })
  vim.keymap.set("n", "<leader>nd", function()
    vim.diagnostic.goto_next()
  end, { buffer = bufnr, remap = false })
  vim.keymap.set("n", "<leader>pd", function()
    vim.diagnostic.goto_prev()
  end, { buffer = bufnr, remap = false })

  -- Disable tsserver formatting as it conflicts with prettier.
  if client.name == "tsserver" then
    client.server_capabilities.documentFormattingProvider = false
  end
end)

lsp.setup()
