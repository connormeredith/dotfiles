local null_ls = require("null-ls")

-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local sources = {
  diagnostics.eslint.with({
    only_local = "node_modules/.bin",
  }),
  formatting.prettier.with({
    only_local = "node_modules/.bin",
  }),
  formatting.black.with({
    only_local = ".venv/bin",
  }),
  diagnostics.mypy.with({
    only_local = ".venv/bin",
  }),
  formatting.stylua,
}

-- Format on save.
-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save#code
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local on_attach = function(client, bufnr)
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
end

null_ls.setup({
  on_attach = on_attach,
  sources = sources,
})
