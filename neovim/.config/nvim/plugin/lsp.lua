vim.pack.add({
  "https://github.com/neovim/nvim-lspconfig",

  -- Language server installation.
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/mason-org/mason-lspconfig.nvim",

  -- Linting and formatting.
  "https://github.com/nvimtools/none-ls.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
})

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "eslint",
    "lua_ls",
    "ts_ls",
  },
})

local null_ls = require("null-ls")
local formatting = null_ls.builtins.formatting
null_ls.setup({
  sources = {
    formatting.stylua,
  },
})

-- Configure LSP keymaps and autocommands.
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc)
      vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
    end

    map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    map("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    map("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    map("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
    map("<F2>", vim.lsp.buf.rename, "Rename symbol")
    map("gl", vim.diagnostic.open_float, "Show diagnostic")

    local client = assert(vim.lsp.get_client_by_id(event.data.client_id))

    -- Format on save.
    if client:supports_method("textDocument/formatting") then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = event.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
        end,
      })
    end

    -- Highlight references on hover.
    if client:supports_method("textDocument/documentHighlight") then
      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        callback = vim.lsp.buf.clear_references,
      })
    end
  end,
})
