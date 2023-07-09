lvim.plugins = {
	-- zen mode in vim
	"folke/zen-mode.nvim",
	-- Search and replace
	"windwp/nvim-spectre",
	-- Pairs of handy bracket mappings
	"tpope/vim-unimpaired",
	-- Better vim repeat
	"tpope/vim-repeat",
	-- extended incrementing/decrementing
	"tpope/vim-speeddating",
	-- Play with delimiters
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- Additional typescript functionalities
	{
		"jose-elias-alvarez/typescript.nvim",
		config = function()
			require("typescript").setup({
				disable_commands = false, -- prevent the plugin from creating Vim commands
				debug = false, -- enable debug logging for commands
				go_to_source_definition = {},
				fallback = true, -- fall back to standard LSP definition on failure
				server = {},
			})
		end,
	},
	-- Use Ctrl + h,j,k,l to navigate across vim and tmux
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
	},
	-- Hop to stuff
	{
		"phaazon/hop.nvim",
		event = "BufRead",
		config = function()
			require("hop").setup()
			vim.api.nvim_set_keymap("n", "s", ":HopChar2<cr>", { silent = true })
			vim.api.nvim_set_keymap("n", "S", ":HopWord<cr>", { silent = true })
		end,
	},
	-- View nicer diagnostics
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
	-- Preview markdown using glow
	{ "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
	-- View colors in files
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
			},
		},
	},
	-- Show tailwind colors
	{
		"roobert/tailwindcss-colorizer-cmp.nvim",
		config = function()
			require("tailwindcss-colorizer-cmp").setup({
				color_square_width = 2,
			})
		end,
	},
	-- Highlight todo's and other markers
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-lua/plenary.nvim",
		config = function()
			require("todo-comments").setup({})
		end,
	},
	-- Pick up where you left off
	{
		"ethanholz/nvim-lastplace",
		event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = {
					"gitcommit",
					"gitrebase",
					"svn",
					"hgcommit",
				},
				lastplace_open_folds = true,
			})
		end,
	},
	-- adds highlights for text filetypes, like markdown
	{
		"lukas-reineke/headlines.nvim",
		dependencies = "nvim-treesitter/nvim-treesitter",
		config = true,
	},
	-- Sync-edit html/jsx tags
	{
		"windwp/nvim-ts-autotag",
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	-- Comment stuff in jsx/tsx correctly
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		event = "BufRead",
	},
	-- Show function signature when you type
	{
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("lsp_signature").on_attach()
		end,
	},
	-- open url with gx
	{ "felipec/vim-sanegx", event = "BufRead" },
}
