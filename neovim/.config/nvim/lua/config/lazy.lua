local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  dev = {
    path = "~/.config/nvim/lua/custom-plugins/",
  },
  spec = {
    import = "config.plugins",
  },
  change_detection = {
    notify = false,
  },
  install = {
    colorscheme = { "tokyonight-moon" },
  },
})
