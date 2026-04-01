vim.pack.add({
  "https://github.com/nvim-treesitter/nvim-treesitter",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if not lang then
      return
    end

    -- Auto-install parsers.
    if not vim.treesitter.language.add(lang) then
      local ts = require("nvim-treesitter")

      if vim.tbl_contains(ts.get_available(), lang) then
        ts.install(lang)
      end
    end

    if vim.treesitter.language.add(lang) then
      -- Enable syntax highlighting.
      vim.treesitter.start()

      -- Enable indentation.
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
