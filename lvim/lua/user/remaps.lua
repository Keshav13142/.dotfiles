local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

local function nmap(key, map)
	keymap("n", key, map, opts)
end

local function vmap(key, map)
	keymap("v", key, map, opts)
end

local function imap(key, map)
	keymap("i", key, map, opts)
end

-- move lines up and down
vmap("J", ":m '>+1<CR>gv=gv")
vmap("K", ":m '<-2<CR>gv=gv")

-- Center cursor
nmap("<C-u>", "<C-u>zz")
nmap("<C-d>", "<C-d>zz")
nmap("n", "nzz")
nmap("N", "Nzz")
nmap("*", "*zz")
nmap("#", "#zz")
nmap("g*", "g*zz")
nmap("g#", "g#zz")

-- Ctrl+s to save
keymap({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- paste and delete register stuff
vmap("<leader>P", '"_dP')
vmap("<leader>D", '"_x')
nmap("Y", "0y$")
-- Do not copy on x
nmap("x", '"_x')

-- Increment/decrement
nmap("+", "<C-a>")
nmap("-", "<C-x>")

-- set Shift+u as redo
nmap("<S-u>", "<C-r>")

-- better indenting
vmap("<", "<gv")
vmap(">", ">gv")

-- Search for word under cursor
keymap({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })
nmap("<C-p>", "<cmd>Telescope git_files<cr>")

-- remap ^ and $ (meta/windows key is not working, have to check)
keymap({ "n", "v", "x", "o" }, "gh", "^", opts)
-- remove existing lsp mapping
lvim.lsp.buffer_mappings.normal_mode["gl"] = nil
keymap({ "n", "v", "x", "o" }, "gl", "$", opts)

-- cycle between tabs
nmap("<S-h>", ":BufferLineCyclePrev<CR>")
nmap("<S-l>", ":BufferLineCycleNext<CR>")

-- quit
nmap("<C-w>", ":q!<CR>")
imap("<C-w>", "<ESC>:q!<CR>")

-- Move to window using the movement keys
nmap("<left>", "<C-w>h")
nmap("<down>", "<C-w>j")
nmap("<up>", "<C-w>k")
nmap("<right>", "<C-w>l")

-- change word with <c-c>
nmap("<C-c>", "<cmd>normal! ciw<cr>a")

-- open floating terminal inside lvim
lvim.builtin.terminal.open_mapping = "<C-t>"
