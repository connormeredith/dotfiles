vim.pack.add({
  "https://github.com/nvim-telescope/telescope.nvim",
  "https://github.com/nvim-lua/plenary.nvim",
  "https://github.com/nvim-telescope/telescope-ui-select.nvim",
})

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
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown(),
    },
  },
})

-- Set vim.ui.select to use telescope.
local load_extension = require("telescope").load_extension
load_extension("ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.git_files, { desc = "Search Git Files" })
vim.keymap.set("n", "<leader>b", builtin.buffers, { desc = "Search [B]uffers" })

vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "[S]earch [W]ord" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "[S]earch Using [G]rep" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "[S]earch [K]eymaps" })
vim.keymap.set("n", "<leader>so", builtin.vim_options, { desc = "[S]each Vim [O]ptions" })

vim.keymap.set("n", "<leader>.", builtin.resume, { desc = "Resume Previous Telescope Window" })
vim.keymap.set("n", "<leader><Space>", builtin.builtin, { desc = "Search Telescope Builtins" })
vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Search Old Files" })
