return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      hide_gitignored = false,
      visible = true,
      hide_dotfiles = false,
      hide_by_name = {
        "node_modules",
      },
    },
    window = {
      position = "right",
    },
  },
}
