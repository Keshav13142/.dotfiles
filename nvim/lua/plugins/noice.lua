return {
  "folke/noice.nvim",
  opts = {
    -- disable popup command line
    cmdline = {
      enabled = true,
    },
    presets = {
      lsp_doc_border = true,
    },
    lsp = {
      progress = {
        enabled = true,
      },
    },
    messages = {
      enabled = false,
    },
  },
}
