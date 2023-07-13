-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local fn = vim.fn
if fn.executable("rg") then
  -- if ripgrep installed, use that as a grepper
  vim.opt.grepprg = "rg --vimgrep --no-heading"
  vim.opt.grepformat = "%f:%l:%c:%m,%f:%l:%m"
  -- create autocmd to automatically open quickfix window when grepping
  vim.cmd([[autocmd QuickFixCmdPost [^l]* nested cwindow]])
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local options = {
  backspace = "indent,eol,start",
  backup = false, -- creates a backup file
  breakindent = true,
  clipboard = "unnamedplus", -- allows neovim to access the system clipboard
  cmdheight = 1, -- more space in the neovim command line for displaying messages
  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
  conceallevel = 0, -- so that `` is visible in markdown files
  confirm = true, -- Confirm to save changes before exiting modified buffer
  cursorline = false, -- highlight the current line
  errorbells = false,
  expandtab = true, -- convert tabs to spaces
  fcs = "eob: ",
  fileencoding = "utf-8", -- the encoding written to a file
  foldenable = false, -- don't fold by default
  foldexpr = "nvim_treesitter#foldexpr()",
  foldlevel = 1,
  foldlevelstart = 99,
  foldmethod = "expr",
  foldnestmax = 10, -- deepest fold is 10 levels,
  formatoptions = "jcroqlnt", -- tcqj
  grepformat = "%f:%l:%c:%m",
  grepprg = "rg --vimgrep",
  ignorecase = true, -- ignore case in search patterns
  incsearch = true,
  laststatus = 3, -- The value of this option influences when the last window will have a status line
  lazyredraw = false, -- don't redraw while executing macros
  linebreak = true,
  list = false, -- turn this on the see EOL and other stuff like that
  listchars = { tab = "→ ", eol = "¬", trail = "⋅", extends = "❯", precedes = "❮" },
  magic = true, -- for regular expressions
  mouse = "a", -- allow the mouse to be used in neovim
  number = true, -- set numbered lines
  numberwidth = 1, -- set number column width to 2 {default 4}
  pumheight = 10, -- pop up menu height
  relativenumber = true, -- set relative numbered lines
  ruler = false, -- Show the line and column number of the cursor position
  scrolloff = 0,
  shell = "zsh",
  shiftround = true,
  shiftwidth = 2, -- the number of spaces inserted for each indentation
  showbreak = "↪",
  showcmd = false, -- Show (partial) command in the last line of the screen.
  showmode = false, -- we don't need to see things like -- INSERT -- anymore
  sidescrolloff = 8,
  signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
  smartcase = true, -- smart case
  smartindent = true, -- make indenting smarter again
  splitbelow = true, -- force all horizontal splits to go below current window
  splitright = true, -- force all vertical splits to go to the right of current window
  swapfile = false, -- creates a swapfile
  tabstop = 2, -- insert 2 spaces for a tab
  termguicolors = true, -- set term gui colors (most terminals support this)
  timeoutlen = 1000, -- time to wait for a mapped sequence to complete (in milliseconds)
  title = true,
  titleold = vim.split(os.getenv("SHELL") or "", "/")[3],
  ttyfast = true,
  undofile = true, -- enable persistent undo
  updatetime = 100, -- faster completion (4000ms default)
  visualbell = true,
  wrap = true, -- Wrap lines
  wrapmargin = 8,
  writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
