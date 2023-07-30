return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("telescope").setup({
      defaults = {
        sorting_strategy = "ascending",
        layout_config = {
          prompt_position = "top",
        },
      },
      pickers = {
        git_files = {
          show_untracked = true,
        },
        find_files = {
          hidden = true,
        },
      },
    })

    local builtin = require("telescope.builtin")

    vim.keymap.set("n", "<leader>.", builtin.resume, {})
    vim.keymap.set("n", "<leader>,", builtin.buffers, {})
    vim.keymap.set("n", "<leader><Space>", builtin.builtin, {})
    vim.keymap.set("n", "<leader>?", builtin.oldfiles, {})

    -- Search.
    vim.keymap.set("n", "<C-p>", builtin.git_files, {})
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, {})
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, {})
    vim.keymap.set("n", "<leader>sf", builtin.find_files, {})
    vim.keymap.set("n", "<leader>sg", builtin.live_grep, {})
    vim.keymap.set("n", "<leader>sw", builtin.grep_string, {})
    vim.keymap.set("v", "<leader>sW", builtin.grep_string, {})
    vim.keymap.set("n", "<leader>sk", builtin.keymaps, {})
    vim.keymap.set("n", "<leader>sM", builtin.man_pages, {})
    vim.keymap.set("n", "<leader>so", builtin.vim_options, {})
  end,
}
