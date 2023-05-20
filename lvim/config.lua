-- Vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.relativenumber = true
vim.opt.incsearch = true
vim.opt.wrap = true -- wrap lines

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Enable Transparent Windows
lvim.transparent_window = true
lvim.builtin.terminal.open_mapping = "<C-t>"

-- General
lvim.log.level = "info"
lvim.format_on_save = true
lvim.use_icons = true

lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

-- Cycle between tabs using H and L
lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<C-s>"] = ":w<CR>"
lvim.keys.insert_mode["<C-s>"] = "<ESC>:w<CR>"
lvim.keys.normal_mode["<C-a>"] = "ggVG"
lvim.keys.insert_mode["<C-a>"] = "<ESC>ggVG"
lvim.keys.normal_mode["<C-q>"] = ":q!<CR>"
lvim.keys.insert_mode["<C-q>"] = "<ESC>:q!<CR>"

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }

lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.dap.active = false
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "right"
lvim.builtin.nvimtree.setup.renderer.icons.show.git = true

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "prettier", filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css" } },
	{ command = "shfmt", filetypes = { "sh", "zsh", "bash" } },
	{ command = "stylua", filetypes = { "lua" } },
})

vim.filetype.add({
	extension = {
		zsh = "zsh",
	},
})

lvim.plugins = {
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
		end,
	},
	{
		"folke/trouble.nvim",
		dependencies = "nvim-tree/nvim-web-devicons",
		cmd = "TroubleToggle",
		config = function()
			require("trouble").setup({
				height = 5,
				padding = false,
			})
		end,
	},
	{ "ellisonleao/glow.nvim", ft = { "markdown" } },
	{ "ray-x/lsp_signature.nvim" },
	{ "folke/zen-mode.nvim" },
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "*" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
	},
	{ "kylechui/nvim-surround" },
	{
		"tpope/vim-fugitive",
		cmd = {
			"G",
			"Git",
			"Gdiffsplit",
			"Gread",
			"Gwrite",
			"Ggrep",
			"GMove",
			"GDelete",
			"GBrowse",
			"GRemove",
			"GRename",
			"Glgrep",
			"Gedit",
		},
		ft = { "fugitive" },
	},
	{
		"felipec/vim-sanegx",
		event = "BufRead",
	},
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
}

lvim.builtin.treesitter.autotag.enable = true
