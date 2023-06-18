return {
  "ray-x/lsp_signature.nvim",
  "folke/zen-mode.nvim",
  "windwp/nvim-spectre",
  "kylechui/nvim-surround",
  "tpope/vim-speeddating",
  "tpope/vim-unimpaired",
  "tpope/vim-repeat",
  {
    "jose-elias-alvarez/typescript.nvim",
    config = function()
      require("typescript").setup({
        disable_commands = false, -- prevent the plugin from creating Vim commands
        debug = false, -- enable debug logging for commands
        go_to_source_definition = {
          fallback = true, -- fall back to standard LSP definition on failure
        },
        server = {},
      })
    end,
  },
  {
    "felipec/vim-sanegx",
    event = "BufRead",
  },
}
