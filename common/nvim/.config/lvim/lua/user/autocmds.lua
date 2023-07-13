local function augroup(name)
	return vim.api.nvim_create_augroup("keshav" .. name, { clear = true })
end
local au = vim.api.nvim_create_autocmd
local defaults = augroup("Defaults")

au("BufWritePost", {
	pattern = { "*tmux.conf" },
	command = "execute 'silent !tmux source <afile> --silent'",
})

au("BufWritePost", {
	pattern = { ".skhdrc" },
	command = "!killall -q sxhkd && sxhkd &",
})

au({ "BufRead" }, {
	pattern = { "*.conf" },
	callback = function()
		vim.cmd([[set filetype=sh]])
	end,
})

au({ "BufRead" }, {
	pattern = { "*.rasi" },
	callback = function()
		vim.cmd([[set filetype=sass]])
	end,
})

au("BufEnter", {
	pattern = { "*" },
	callback = function()
		vim.cmd([[set formatoptions-=cro]])
	end,
})

-- Strip trailing spaces before write
au({ "BufWritePre" }, {
	group = augroup("strip_space"),
	pattern = { "*" },
	callback = function()
		vim.cmd([[ %s/\s\+$//e ]])
	end,
})

au({ "TextYankPost" }, {
	callback = function()
		vim.highlight.on_yank({ higroup = "Visual", timeout = 40 })
	end,
})

au("Termopen", {
	desc = "Unclutter terminal",
	group = defaults,
	pattern = { "*" },
	command = "setlocal nonumber norelativenumber scrolloff=0",
})
