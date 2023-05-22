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

-- ############################### This is extremely slow when saving (idk why) ##################################
-- local status_ok, null_ls = pcall(require, "null-ls")
-- if not status_ok then
-- 	return
-- end

-- local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
-- local hover = null_ls.builtins.hover
-- local code_actions = null_ls.builtins.code_actions
-- local completion = null_ls.builtins.completion

-- null_ls.setup({
-- 	debug = false,
-- 	border = "rounded",
-- 	log_level = "error",
-- 	diagnostics_format = "#{c} #{m} (#{s})",
-- 	sources = {
-- 		code_actions.eslint,
-- 		code_actions.proselint,
-- 		code_actions.refactoring,
-- 		code_actions.shellcheck,
-- 		completion.spell,
-- 		completion.tags,
-- 		diagnostics.eslint,
-- 		diagnostics.rubocop,
-- 		diagnostics.selene,
-- 		diagnostics.shellcheck,
-- 		formatting.black.with({ extra_args = { "--fast" } }),
-- 		formatting.eslint,
-- 		formatting.prettier,
-- 		formatting.rubocop,
-- 		formatting.shfmt,
-- 		formatting.stylua,
-- 		hover.dictionary,
-- 		hover.printenv,
-- 		-- diagnostics.cspell.with({
-- 		--     {
-- 		--         disabled_filetypes = { "lua" },
-- 		--         filetypes = { "html", "json", "yaml", "markdown" },
-- 		--         extra_args = { "--config ~/.cspell.json" },
-- 		--     },
-- 		-- }),
-- 		-- code_actions.cspell.with({
-- 		--     {
-- 		--         disabled_filetypes = { 'lua' },
-- 		--         filetypes = { 'html', 'json', 'yaml', 'markdown' },
-- 		--         extra_args = { '--config ~/.cspell.json' },
-- 		--     },
-- 		-- }),
-- 	},
-- })
