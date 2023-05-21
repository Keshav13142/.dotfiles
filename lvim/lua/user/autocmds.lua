vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { "*tmux.conf" },
	command = "execute 'silent !tmux source <afile> --silent'",
})

vim.api.nvim_create_autocmd("BufWritePost", {
	pattern = { ".skhdrc" },
	command = "!brew services restart skhd",
})

-- vim.api.nvim_create_autocmd({ "BufNewFile", "BufFilePre", "BufRead" }, {
--   pattern = { "*.mdx", "*.md" },
--   callback = function()
--     vim.cmd([[set filetype=markdown wrap linebreak nolist]])
--   end,
-- })

vim.api.nvim_create_autocmd({ "BufRead" }, {
	pattern = { "*.conf" },
	callback = function()
		vim.cmd([[set filetype=sh]])
	end,
})

vim.api.nvim_create_autocmd({ "BufRead" }, {
	pattern = { "*.rasi" },
	callback = function()
		vim.cmd([[set filetype=sass]])
	end,
})
