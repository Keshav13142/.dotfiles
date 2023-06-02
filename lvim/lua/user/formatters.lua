local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	-- { command = "prettier", filetypes = { "javascript", "typescript", "javascriptreact", "typescriptreact", "css" } },
	{ command = "shfmt", filetypes = { "sh", "zsh", "bash" } },
	{ command = "stylua", filetypes = { "lua" } },
	{ command = "goimports", filetypes = { "go" } },
	{ command = "gofumpt", filetypes = { "go" } },
})

local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "eslint", filetypes = { "javascript", "typescript" } },
})

vim.filetype.add({
	extension = {
		zsh = "zsh",
	},
})
