local wezterm = require("wezterm")
local mux = wezterm.mux
local config = wezterm.config_builder()

local is_windows = function()
	return wezterm.target_triple:find("windows") ~= nil
end

local is_mac = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

if is_windows() then
	config.default_domain = "WSL:Ubuntu"
	config.audible_bell = "Disabled"
end

config.color_scheme = "Kanagawa (Gogh)"

config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

if is_mac() then
	config.native_macos_fullscreen_mode = true
else
	config.window_decorations = "RESIZE"
	-- Maximize window on launch
	wezterm.on("gui-startup", function()
		local tab, pane, window = mux.spawn_window({})
		window:gui_window():maximize()
	end)
end

local font_family = "Berkeley Mono"
config.font = wezterm.font({ family = font_family })
config.font_rules = {
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font({
			family = font_family,
			weight = "Bold",
		}),
	},
	{
		intensity = "Normal",
		italic = true,
		font = wezterm.font({
			family = font_family,
			style = "Italic",
		}),
	},
}

local switch_pane_keymap = function(key, direction)
	return {
		key = key,
		mods = "CTRL",
		action = wezterm.action.ActivatePaneDirection(direction),
	}
end

-- Keybindings
config.keys = {
	switch_pane_keymap("h", "Left"),
	switch_pane_keymap("j", "Down"),
	switch_pane_keymap("k", "Up"),
	switch_pane_keymap("l", "Right"),
	{ -- <S-A-t> create a new tab in current domain
		key = "t",
		mods = "SHIFT|ALT",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{ -- <C-S-A-%> split current pane horizontally
		key = "%",
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{ -- <C-S-A-"> split current pane vertically
		key = '"',
		mods = "CTRL|SHIFT|ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}

return config
