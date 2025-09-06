local M = {}

function M.setup()
  vim.api.nvim_create_user_command("Dockerlsp", function(opts)
    local cwd_path_parts = vim.split(vim.fn.getcwd(), "/", { trimempty = true })
    local base_dir = cwd_path_parts[#cwd_path_parts]
    local dockerfile = "~/.config/nvim/docker-lsp/" .. base_dir .. "/Dockerfile"

    if vim.fn.filereadable(vim.fn.expand(dockerfile)) == 1 then
      local buf = vim.api.nvim_create_buf(false, true)
      local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = vim.o.columns - 16,
        height = vim.o.lines - 16,
        style = "minimal",
        border = { " ", " ", " ", " ", " ", " ", " ", " " },
        col = 8,
        row = 4,
      })

      vim.api.nvim_buf_set_keymap(buf, "n", "q", ":close<CR>", {})

      local curr_line = 0

      vim.fn.jobstart("docker build -f " .. dockerfile .. " " .. vim.fn.getcwd() .. " -t lsp/" .. base_dir, {
        on_stderr = function(_, data)
          if not data then
            return
          end

          for idx, line in ipairs(data) do
            vim.api.nvim_buf_set_lines(buf, curr_line, curr_line, false, { line })
            curr_line = curr_line + 1
            vim.api.nvim_win_set_cursor(win, { curr_line, 0 })
          end
        end,
        on_exit = function()
          vim.api.nvim_buf_set_lines(buf, curr_line, curr_line, false, { "[FINISHED]" })
          curr_line = curr_line + 1
          vim.api.nvim_win_set_cursor(win, { curr_line, 0 })
        end,
      })
    else
      print("No Dockerfile found.")
    end
  end, {})

  vim.keymap.set("n", "<leader>db", ":Dockerlsp<CR>")
end

return M
