local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "prettier", filetypes = { "css" } },
	{ command = "shfmt", filetypes = { "sh", "zsh", "bash" } },
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "goimports", filetypes = { "go" } },
	{ command = "gofumpt", filetypes = { "go" } },
	{ command = "nixpkgs_fmt", filetypes = { "nix" } },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "eslint", filetypes = { "javascript", "typescript" } },
	{ command = "deadnix", filetypes = { "nix" } },
	{ command = "shellcheck", filetypes = { "sh", "zsh", "bash" } },
})

local code_actions = require("lvim.lsp.null-ls.code_actions")
code_actions.setup({
	{ command = "statix", filetypes = { "nix" } },
})

vim.filetype.add({
	extension = {
		zsh = "zsh",
	},
})
