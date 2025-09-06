local M = {}

function M.setup()
  vim.lsp.config["ts_ls"] = {
    on_attach = function(client, bufnr)
      -- Disable ts_ls formatting as it conflicts with prettier.
      client.server_capabilities.documentFormattingProvider = false
    end,
  }

  vim.lsp.config["eslint"] = {
    on_attach = function(client, bufnr)
      -- Apply eslint fixes on save.
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = bufnr,
        callback = function()
          client:request_sync("workspace/executeCommand", {
            command = "eslint.applyAllFixes",
            arguments = {
              {
                uri = vim.uri_from_bufnr(bufnr),
                version = vim.lsp.util.buf_versions[bufnr],
              },
            },
          })
        end,
      })
    end,
  }

  vim.lsp.config["pylsp"] = {
    cmd = (function()
      local cwd = vim.fn.getcwd()
      local cwd_path_parts = vim.split(cwd, "/", { trimempty = true })
      local base_dir = cwd_path_parts[#cwd_path_parts]
      local dockerfile = "~/.config/nvim/docker-lsp/" .. base_dir .. "/Dockerfile"

      if vim.fn.filereadable(vim.fn.expand(dockerfile)) ~= 1 then
        return nil
      end

      return {
        "docker",
        "run",
        "-i",
        "--name",
        "lsp-" .. base_dir,
        "--rm",
        "--workdir=" .. cwd,
        "--volume=" .. cwd .. ":" .. cwd,
        "lsp/" .. base_dir,
      }
    end)(),
    settings = {
      pylsp = {
        plugins = {
          black = {
            enabled = true,
          },
          flake8 = {
            enabled = true,
          },
          mccabe = {
            enabled = false,
          },
          pycodestyle = {
            enabled = false,
          },
          pyflakes = {
            enabled = false,
          },
          pylsp_mypy = {
            enabled = false,
            dmypy = true,
            report_progress = true,
            live_mode = false,
          },
          pylint = {
            enabled = true,
          },
          rope_completion = {
            enabled = true,
          },
        },
      },
    },
  }

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
end

return M
