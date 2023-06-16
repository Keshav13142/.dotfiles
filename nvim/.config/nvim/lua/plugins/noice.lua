return {
  "folke/noice.nvim",
  opts = {
    -- disable popup command line
    cmdline = {
      enabled = false,
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
