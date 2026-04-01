return {
  on_attach = function(client, bufnr)
    -- Disable ts_ls formatting as it conflicts with prettier.
    client.server_capabilities.documentFormattingProvider = false
  end,
}
