-- General
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.use_icons = true
lvim.leader = "space"
lvim.transparent_window = true
lvim.reload_config_on_save = true
lvim.builtin.illuminate.active = true
lvim.builtin.bufferline.active = true
lvim.builtin.terminal.persist_mode = false
lvim.builtin.breadcrumbs.active = false
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.dap.active = false
lvim.builtin.terminal.active = true
lvim.builtin.lualine.active = false

-- nvim-tree config
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true
lvim.builtin.nvimtree.setup.filters.dotfiles = true
lvim.builtin.nvimtree.setup.view.centralize_selection = true

local options = {
	backup = false, -- creates a backup file
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	cmdheight = 1, -- more space in the neovim command line for displaying messages
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	conceallevel = 0, -- so that `` is visible in markdown files
	fileencoding = "utf-8", -- the encoding written to a file
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 10, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 100, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- insert 2 spaces for a tab
	cursorline = false, -- highlight the current line
	number = true, -- set numbered lines
	laststatus = 3, -- The value of this option influences when the last window will have a status line
	showcmd = false, -- Show (partial) command in the last line of the screen.
	ruler = false, -- Show the line and column number of the cursor position
	relativenumber = true, -- set relative numbered lines
	numberwidth = 1, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	scrolloff = 0,
	sidescrolloff = 8,
	title = true,
	incsearch = true,
	wrap = true, -- Wrap lines
	titleold = vim.split(os.getenv("SHELL") or "", "/")[3],
}

for k, v in pairs(options) do
	vim.opt[k] = v
end
