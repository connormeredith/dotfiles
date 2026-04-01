return {
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
