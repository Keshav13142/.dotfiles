local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local lnmap = lvim.keys.normal_mode
local limap = lvim.keys.insert_mode

-- move lines up and down
keymap("v", "J", ":m '>+1<CR>gv=gv")
keymap("v", "K", ":m '<-2<CR>gv=gv")

-- Center cursor
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*zz", opts)
keymap("n", "#", "#zz", opts)
keymap("n", "g*", "g*zz", opts)
keymap("n", "g#", "g#zz", opts)

-- Ctrl+s to save
keymap({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- paste and delete register stuff
keymap("v", "<leader>P", '"_dP', opts)
keymap("v", "<leader>D", '"_x', opts)
keymap("n", "Y", "0y$", { noremap = true })
-- Do not copy on x
keymap("n", "x", '"_x', opts)

-- Increment/decrement
keymap("n", "+", "<C-a>", opts)
keymap("n", "-", "<C-x>", opts)

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Search for word under cursor
keymap({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
keymap("n", "<C-p>", "<cmd>Telescope git_files<cr>", opts)

-- remap ^ and $
keymap("n", "<C-h>", "^", opts)
keymap("n", "<C-l>", "$", opts)
keymap("v", "<C-h>", "^", opts)
keymap("v", "<C-l>", "$", opts)
keymap("x", "<C-h>", "^", opts)
keymap("x", "<C-l>", "$", opts)
keymap("o", "<C-h>", "^", opts)
keymap("o", "<C-l>", "$", opts)

-- normal mode remaps
lnmap["<S-h>"] = ":BufferLineCyclePrev<CR>"
lnmap["<S-l>"] = ":BufferLineCycleNext<CR>"
-- lnmap["<C-s>"] = ":w<CR>"
lnmap["<C-q>"] = ":q!<CR>"
-- insert mode remaps
limap["<C-q>"] = "<ESC>:q!<CR>"
-- limap["<C-s>"] = "<ESC>:w<CR>"

-- open floating terminal inside lvim
lvim.builtin.terminal.open_mapping = "<C-t>"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
