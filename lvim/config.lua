-- Vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Enable Transparent Windows
lvim.transparent_window = true

-- General
lvim.log.level = "info"
lvim.format_on_save = true
lvim.use_icons = true

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Cycle between tabs using H and L
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.dap.active = false
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { command = "prettier", filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css" } },
  { command = "shfmt",    filetypes = { "sh", "zsh", "bash" } },
  { command = "stylua",   filetypes = { "lua" } },
}

vim.filetype.add {
  extension = {
    zsh = "zsh",
  },
}

--  Formatting config
-- local nls = require("null-ls")
-- nls.setup {
--   on_attach = require("lvim.lsp").common_on_attach,
--   debounce = 150,
--   save_after_format = false,
--   sources = {
--     nls.builtins.formatting.prettierd.with {
--       condition = function(utils)
--         return not utils.root_has_file { ".eslintrc", ".eslintrc.js" }
--       end,
--       prefer_local = "node_modules/.bin",
--     },
--     nls.builtins.formatting.eslint_d.with {
--       condition = function(utils)
--         return utils.root_has_file { ".eslintrc", ".eslintrc.js" }
--       end,
--       prefer_local = "node_modules/.bin",
--     },
--   },
-- }
