vim.filetype.add({
  pattern = {
    [".*main.ya?ml"] = "yaml.ansible",
    [".*handlers/.*%.ya?ml"] = "yaml.ansible",
    [".*roles/.*%.ya?ml"] = "yaml.ansible",
    [".*tasks/.*%.ya?ml"] = "yaml.ansible",
    ["Brewfile"] = "ruby",
  },
})
