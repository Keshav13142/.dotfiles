local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }
local nmap = lvim.keys.normal_mode
local imap = lvim.keys.insert_mode

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

-- set Shift+u as redo
keymap("n", "<S-u>", "<C-r>", opts)

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Search for word under cursor
keymap({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
keymap("n", "<C-p>", "<cmd>Telescope git_files<cr>", opts)

-- remap ^ and $ (meta/windows key is not working, have to check)
keymap({ "n", "v", "x", "o" }, "gh", "^", opts)
-- remove existing lsp mapping
lvim.lsp.buffer_mappings.normal_mode["gl"] = nil
keymap({ "n", "v", "x", "o" }, "gl", "$", opts)

-- cycle between tabs
nmap["<S-h>"] = ":BufferLineCyclePrev<CR>"
nmap["<S-l>"] = ":BufferLineCycleNext<CR>"

-- quit
nmap["<C-q>"] = ":q!<CR>"
imap["<C-q>"] = "<ESC>:q!<CR>"

-- open floating terminal inside lvim
lvim.builtin.terminal.open_mapping = "<C-t>"
