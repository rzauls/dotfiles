local wezterm = require("wezterm")
local config = wezterm.config_builder()

local is_windows = function()
	return wezterm.target_triple:find("windows") ~= nil
end

local is_mac = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

local function is_vim(pane)
	return pane:get_user_vars().IS_NVIM == "true"
end

if is_windows() then
	config.default_domain = "WSL:Ubuntu"
	config.audible_bell = "Disabled"
	config.window_decorations = "INTEGRATED_BUTTONS|TITLE|RESIZE"
end

if is_mac() then
	config.window_decorations = "RESIZE"
	config.native_macos_fullscreen_mode = true
	config.hide_tab_bar_if_only_one_tab = false
end

config.color_scheme = "Kanagawa (Gogh)"

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

local direction_keys = {
	h = "Left",
	j = "Down",
	k = "Up",
	l = "Right",
}

local function split_nav(resize_or_move, key)
	return {
		key = key,
		mods = resize_or_move == "resize" and "META" or "CTRL",
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

wezterm.on("update-right-status", function(window, pane)
	local leader = ""
	if window:leader_is_active() then
		leader = "LEADER"
	end
	window:set_right_status(leader)
end)

-- Keybindings
config.leader = {
	key = " ",
	mods = "CTRL",
	timeout_milliseconds = 1000,
}
config.keys = {
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
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action.SpawnWindow,
	},
	{
		key = "h", -- wezterm horizontal/vertical splits are opposite of how vim naming works
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "v", -- wezterm horizontal/vertical splits are opposite of how vim naming works
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
}

return config
