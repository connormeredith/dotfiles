local lsp = require("lsp-zero")
local null_ls = require("null-ls")
local cmp = require("cmp")

lsp.preset("recommended")

lsp.ensure_installed({
  "tsserver",
  "rust_analyzer",
  "lua_ls",
  "pylsp",
  "bashls",
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

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
})

local null_opts = lsp.build_options("null-ls", {})
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  on_attach = function(client, bufnr)
    null_opts.on_attach(client, bufnr)

    -- Format on save.
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
  sources = {
    null_ls.builtins.diagnostics.eslint.with({
      only_local = "node_modules/.bin",
    }),
    null_ls.builtins.formatting.prettier.with({
      only_local = "node_modules/.bin",
    }),
    null_ls.builtins.formatting.black.with({
      only_local = ".venv/bin",
    }),
    null_ls.builtins.diagnostics.mypy.with({
      only_local = ".venv/bin",
    }),
    null_ls.builtins.formatting.stylua,
  },
})
