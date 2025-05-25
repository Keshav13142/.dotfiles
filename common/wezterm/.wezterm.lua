local wezterm = require("wezterm")
local act = wezterm.action

-- Status bar right info
wezterm.on("update-right-status", function(window, pane)
	local cwd = " " .. pane:get_current_working_dir():sub(8) .. " " -- remove file:// uri prefix
	local date = wezterm.strftime(" %A, %B %-d, %I:%M %p ")
	local hostname = " " .. wezterm.hostname() .. " "

	window:set_right_status(wezterm.format({
		{ Foreground = { Color = "#928374" } },
		{ Text = cwd },
		{ Text = "|" },
		{ Text = date },
		{ Text = "|" },
		{ Text = hostname },
	}))
end)

-- if you are *NOT* lazy-loading smart-splits.nvim (recommended)
local function is_vim(pane)
	-- this is set by the plugin, and unset on ExitPre in Neovim
	return pane:get_user_vars().IS_NVIM == "true"
end

local direction_keys = {
	Left = "h",
	Down = "j",
	Up = "k",
	Right = "l",
	-- reverse lookup
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "CTRL|SHIFT" or "LEADER",
		action = wezterm.action_callback(function(win, pane)
			if is_vim(pane) then
				-- pass the keys through to vim/nvim
				win:perform_action({
					SendKey = { key = key, mods = resize_or_move == "resize" and "META" or "CTRL" },
				}, pane)
			else
				if resize_or_move == "resize" then
					win:perform_action({ AdjustPaneSize = { direction_keys[key], 3 } }, pane)
				else
					win:perform_action({ ActivatePaneDirection = direction_keys[key] }, pane)
				end
			end
		end),
	}
end

local function isLinux()
	local separator = package.config:sub(1, 1)

	if separator == "/" then
		return true
	end
	return false
end

return {
	window_decorations = "NONE | RESIZE",
	front_end = "WebGpu",
	max_fps = 144,
	animation_fps = 1,
	prefer_egl = true,

	default_prog = not isLinux() and { "nu" } or nil,
	enable_wayland = false, -- to get it working on wayland :)

	-- WSL
	-- default_domain = "WSL:Ubuntu-22.04",
	wsl_domains = {
		{
			name = "WSL:Ubuntu-22.04",
			distribution = "Ubuntu-22.04",
			username = "keshav",
			default_cwd = "~",
		},
	},

	-- Fonts
	font = wezterm.font({
		family = "JetBrainsMono Nerd Font Mono",
	}),
	font_size = 13,

	-- Tab bar
	hide_tab_bar_if_only_one_tab = true,
	show_new_tab_button_in_tab_bar = false,
	show_tab_index_in_tab_bar = true,
	show_tabs_in_tab_bar = true,
	tab_bar_at_bottom = true,
	use_fancy_tab_bar = false,

	-- General
	audible_bell = "Disabled",
	visual_bell = {
		fade_in_duration_ms = 0,
		fade_out_duration_ms = 0,
	},
	pane_focus_follows_mouse = true,
	automatically_reload_config = true,
	exit_behavior = "Close",
	force_reverse_video_cursor = true,
	scrollback_lines = 10000,
	show_update_window = true,
	use_dead_keys = false,

	-- Window
	adjust_window_size_when_changing_font_size = false,
	window_background_opacity = 0.75,
	window_close_confirmation = "NeverPrompt",
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	-- Colors
	colors = {
		background = "#000000",
		tab_bar = {
			background = "#000000",

			active_tab = {
				bg_color = "#000000",
				fg_color = "#d4be98",
				intensity = "Bold",
				underline = "None",
				italic = true,
				strikethrough = false,
			},

			inactive_tab = {
				bg_color = "#000000",
				fg_color = "#7c6f64",
				intensity = "Half",
				underline = "None",
				italic = false,
				strikethrough = false,
			},

			inactive_tab_hover = {
				bg_color = "#32302f",
				fg_color = "#909090",
				italic = true,
			},
		},
	},
	color_scheme = "Gruvbox Dark (Gogh)",

	-- Keymaps
	disable_default_key_bindings = false,
	leader = { key = ";", mods = "CTRL", timeout_milliseconds = 1000 },
	keys = {
		-- Splits
		{
			key = "|",
			mods = "LEADER|SHIFT",
			action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = '"',
			mods = "LEADER|SHIFT",
			action = act.SplitVertical({ domain = "CurrentPaneDomain" }),
		},

		-- Open command pallete
		{
			key = "p",
			mods = "CTRL|SHIFT",
			action = act.ActivateCommandPalette,
		},

		-- Enter copy mode
		{ key = "v", mods = "LEADER", action = act.ActivateCopyMode },

		-- Rename tabs
		{
			key = "r",
			mods = "LEADER",
			action = act.PromptInputLine({
				description = "Enter new name for tab",
				action = wezterm.action_callback(function(window, _, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},

		-- Navigate tabs
		{ key = "1", mods = "CTRL", action = act.ActivateTab(0) },
		{ key = "2", mods = "CTRL", action = act.ActivateTab(1) },
		{ key = "3", mods = "CTRL", action = act.ActivateTab(2) },
		{ key = "4", mods = "CTRL", action = act.ActivateTab(3) },
		{ key = "5", mods = "CTRL", action = act.ActivateTab(4) },
		{ key = "6", mods = "CTRL", action = act.ActivateTab(5) },
		{ key = "[", mods = "CTRL", action = act.ActivateTabRelative(-1) },
		{ key = "]", mods = "CTRL", action = act.ActivateTabRelative(1) },

		-- Move with leader as well
		{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
		{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
		{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
		{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
		{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
		{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },

		-- move between split panes
		split_nav("move", "h"),
		split_nav("move", "j"),
		split_nav("move", "k"),
		split_nav("move", "l"),
		-- resize panes
		split_nav("resize", "h"),
		split_nav("resize", "j"),
		split_nav("resize", "k"),
		split_nav("resize", "l"),

		-- Move pane to new tab
		{
			key = "n",
			mods = "LEADER",
			action = wezterm.action_callback(function(_, pane)
				local _, _ = pane:move_to_new_tab()
			end),
		},

		-- Copy/Paste
		{ action = act.CopyTo("Clipboard"), mods = "CTRL|SHIFT", key = "C" },
		{ action = act.PasteFrom("Clipboard"), mods = "CTRL|SHIFT", key = "V" },

		-- Open new tab
		{
			key = "c",
			mods = "LEADER",
			action = act.SpawnTab("CurrentPaneDomain"),
		},

		-- Close stuff
		{
			key = "q",
			mods = "LEADER",
			action = act.CloseCurrentPane({ confirm = true }),
		},
		{
			key = "w",
			mods = "CTRL|SHIFT",
			action = act.CloseCurrentTab({ confirm = true }),
		},

		-- Cycle through tabs
		{ key = "{", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
		{ key = "}", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },

		-- Font stuff
		{ action = act.DecreaseFontSize, mods = "CTRL", key = "-" },
		{ action = act.IncreaseFontSize, mods = "CTRL", key = "=" },
		{ action = act.ResetFontSize, mods = "CTRL", key = "0" },

		-- Full screen
		{ action = act.ToggleFullScreen, key = "F11" },
	},

	-- https://github.com/keshav13142
	mouse_bindings = {
		-- Ctrl-click will open the link under the mouse cursor
		{
			event = { Up = { streak = 1, button = "Left" } },
			mods = "CTRL",
			action = wezterm.action.OpenLinkAtMouseCursor,
		},
	},
}
