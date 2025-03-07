local wezterm = require("wezterm")
local config = wezterm.config_builder()
local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")

local is_windows = function()
	return wezterm.target_triple:find("windows") ~= nil
end

local is_mac = function()
	return wezterm.target_triple:find("darwin") ~= nil
end

local is_linux = function()
	return wezterm.target_triple:find("linux") ~= nil
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

if is_linux() then
	config.window_decorations = "RESIZE"
	config.hide_tab_bar_if_only_one_tab = true
	-- wezterm.on("gui-startup", function(cmd)
	-- 	local _, _, window = wezterm.mux.spawn_window(cmd or {})
	-- 	window:gui_window():maximize()
	-- end)
end

config.color_scheme = "Apple System Colors"
-- config.color_scheme = "Kanagawa (Gogh)"

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

local font_family = "Berkeley Mono"
-- local font_family = "IBM Plex Mono"
-- local font_family = "JetBrains Mono"
config.font = wezterm.font_with_fallback({
	{ family = font_family },
	"JetBrains Mono",
})
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
		leader = "LEADER  "
	end
	window:set_right_status(leader)
end)

-- session management
wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)
resurrect.state_manager.periodic_save({
	interval_seconds = 5 * 60,
	save_workspaces = true,
	save_windows = true,
	save_tabs = true,
})

-- CMD Palette additional entries
-- TODO: this doesnt work for some reason
wezterm.on("augment-command-palette", function(window, pane)
	return {
		{
			brief = "Rename tab",
			icon = "md_rename_box",

			action = wezterm.action.PromptInputLine({
				description = "Enter new name for tab",
				initial_value = "My Tab Name",
				action = wezterm.action_callback(function(window, pane, line)
					if line then
						window:active_tab():set_title(line)
					end
				end),
			}),
		},
	}
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
	{
		key = "w",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
		end),
	},
	{
		key = "W",
		mods = "LEADER",
		action = resurrect.window_state.save_window_action(),
	},
	{
		key = "T",
		mods = "LEADER",
		action = resurrect.tab_state.save_tab_action(),
	},
	{
		key = "s",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
			resurrect.window_state.save_window_action()
		end),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
				local type = string.match(id, "^([^/]+)") -- match before '/'
				id = string.match(id, "([^/]+)$") -- match after '/'
				id = string.match(id, "(.+)%..+$") -- remove file extention
				local opts = {
					close_open_tabs = true,
					window = pane:window(),
					on_pane_restore = resurrect.tab_state.default_on_pane_restore,
					relative = true,
					restore_text = true,
				}
				if type == "workspace" then
					local state = resurrect.state_manager.load_state(id, "workspace")
					resurrect.workspace_state.restore_workspace(state, opts)
				elseif type == "window" then
					local state = resurrect.state_manager.load_state(id, "window")
					resurrect.window_state.restore_window(pane:window(), state, opts)
				elseif type == "tab" then
					local state = resurrect.state_manager.load_state(id, "tab")
					resurrect.tab_state.restore_tab(pane:tab(), state, opts)
				end
			end)
		end),
	},
	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action_callback(function(win, pane)
			resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id)
				resurrect.state_manager.delete_state(id)
			end, {
				title = "Delete State",
				description = "Select State to Delete and press Enter = accept, Esc = cancel, / = filter",
				fuzzy_description = "Search State to Delete: ",
				is_fuzzy = true,
			})
		end),
	},
}

return config
