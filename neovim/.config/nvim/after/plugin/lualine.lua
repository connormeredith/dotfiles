require("lualine").setup({
  options = {
    theme = "nightfly"
  },
  sections = {
    lualine_a = {
      {
        "filename",
        path = 1
      }
    }
  }
})
