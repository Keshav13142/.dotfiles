lvim.builtin.which_key.mappings["f"] = {
	name = "Find",
	b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
	c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
	f = { "<cmd>Telescope find_files<cr>", "Find files" },
	g = { "<cmd>Telescope git_files<cr>", "Find git files" },
	t = { "<cmd>Telescope live_grep<cr>", "Find Text" },
	s = { "<cmd>Telescope grep_string<cr>", "Find String" },
	h = { "<cmd>Telescope help_tags<cr>", "Help" },
	H = { "<cmd>Telescope highlights<cr>", "Highlights" },
	i = { "<cmd>lua require('telescope').extensions.media_files.media_files()<cr>", "Media" },
	l = { "<cmd>Telescope resume<cr>", "Last Search" },
	M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
	r = { "<cmd>Telescope oldfiles<cr>", "Recent File" },
	R = { "<cmd>Telescope registers<cr>", "Registers" },
	k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
	C = { "<cmd>Telescope commands<cr>", "Commands" },
}

lvim.builtin.which_key.mappings["r"] = {
	name = "Replace",
	r = { "<cmd>lua require('spectre').open()<cr>", "Replace" },
	w = { "<cmd>lua require('spectre').open_visual({select_word=true})<cr>", "Replace Word" },
	f = { "<cmd>lua require('spectre').open_file_search()<cr>", "Replace Buffer" },
}

lvim.builtin.which_key.mappings["s"] = nil
-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["W"] = { "<cmd>noautocmd w<cr>", "Save without formatting" }
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
