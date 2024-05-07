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
	-- config.window_decorations = "TITLE | RESIZE"
	config.native_macos_fullscreen_mode = true
else
	config.window_decorations = "RESIZE"
end

-- Maximize window on launch
wezterm.on("gui-startup", function()
	local tab, pane, window = mux.spawn_window({})
	window:gui_window():maximize()
end)

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

return config
