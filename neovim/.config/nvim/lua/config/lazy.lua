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
  spec = {
    -- Import plugins.
    import = "config.plugins",
  },
  change_detection = {
    -- Don't notify when the config is changed.
    notify = false,
  },
  install = {
    -- Set colourscheme on startup.
    colorscheme = { "tokyonight-moon" },
  },
})
