lvim.builtin.telescope.defaults.file_ignore_patterns = {
	".git/",
	"target/",
	"docs/",
	"vendor/*",
	"%.lock",
	"__pycache__/*",
	"%.sqlite3",
	"%.ipynb",
	"node_modules/*",
	"%.jpg",
	"%.jpeg",
	"%.png",
	"%.svg",
	"%.otf",
	"%.ttf",
	"%.webp",
	".dart_tool/",
	".github/",
	".gradle/",
	".idea/",
	".settings/",
	".vscode/",
	"__pycache__/",
	"build/",
	"env/",
	"gradle/",
	"node_modules/",
	"%.pdb",
	"%.dll",
	"%.class",
	"%.exe",
	"%.cache",
	"%.ico",
	"%.pdf",
	"%.dylib",
	"%.jar",
	"%.docx",
	"%.met",
	"smalljre_*/*",
	".vale/",
	"%.burp",
	"%.mp4",
	"%.mkv",
	"%.rar",
	"%.zip",
	"%.7z",
	"%.tar",
	"%.bz2",
	"%.epub",
	"%.flac",
	"%.tar.gz",
}

local actions = require("telescope.actions")

lvim.builtin.telescope.defaults.mappings = {
	i = {
		["<Esc>"] = actions.close, -- don't go into normal mode, just close
		["<C-t>"] = actions.select_tab, -- open selection in new tab
		["<C-y>"] = actions.preview_scrolling_up,
		["<C-e>"] = actions.preview_scrolling_down,
	},
}

lvim.builtin.telescope.defaults.sorting_strategy = "ascending"
lvim.builtin.telescope.extensions = {
	fzf = { fuzzy = true, override_generic_sorter = true, override_file_sorter = true, case_mode = "smart_case" },
}
