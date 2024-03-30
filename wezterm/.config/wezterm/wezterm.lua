local wezterm = require("wezterm")

local config = wezterm.config_builder()

local is_windows = function()
	return wezterm.target_triple:find("windows") ~= nil
end

-- local is_mac = function()
-- 	return wezterm.target_triple:find("darwin") ~= nil
-- end

if is_windows() then
	config.default_domain = "WSL:Ubuntu"
end

config.color_scheme = "Catppuccin Mocha"

config.window_decorations = "RESIZE"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

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
