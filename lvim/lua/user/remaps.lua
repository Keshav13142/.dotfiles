local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local lnmap = lvim.keys.normal_mode
local limap = lvim.keys.insert_mode

keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")
-- Center stuff
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)
-- Void paste remap
keymap("v", "<leader>P", '"_dP', opts)
-- Void delete remap
keymap("v", "<leader>D", '"_x', opts)
keymap("n", "Y", "0y$", { noremap = true })
-- Harpoon remaps
keymap("n", "<leader>a", ":lua require('harpoon.mark').add_file()<CR>", { desc = "Add to Harpoon" })
keymap("n", "<leader>0", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", { desc = "Show Harpoon" })
keymap("n", "<leader>1", ":lua require('harpoon.ui').nav_file(1)<CR>", { desc = "Harpoon Buffer 1" })
keymap("n", "<leader>2", ":lua require('harpoon.ui').nav_file(2)<CR>", { desc = "Harpoon Buffer 2" })
keymap("n", "<leader>3", ":lua require('harpoon.ui').nav_file(3)<CR>", { desc = "Harpoon Buffer 3" })
keymap("n", "<leader>4", ":lua require('harpoon.ui').nav_file(4)<CR>", { desc = "Harpoon Buffer 4" })

-- normal mode remaps
lnmap["<S-h>"] = ":BufferLineCyclePrev<CR>"
lnmap["<S-l>"] = ":BufferLineCycleNext<CR>"
lnmap["<C-s>"] = ":w<CR>"
-- lnmap["<C-A>"] = "ggVG"
lnmap["<C-q>"] = ":q!<CR>"
-- insert mode remaps
limap["<C-q>"] = "<ESC>:q!<CR>"
limap["<C-s>"] = "<ESC>:w<CR>"
-- limap["<C-A>"] = "<ESC>ggVG"

-- open floating terminal inside lvim
lvim.builtin.terminal.open_mapping = "<C-t>"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
