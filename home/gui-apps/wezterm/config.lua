local wezterm = require("wezterm")
local workspace = require("workspace")

local action = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = "stylix"

config.default_workspace = workspace.HOME_WORKSPACE_NAME

config.font_size = 14
config.font = wezterm.font({ family = "Iosevka NF" })
config.harfbuzz_features = { "calt = 0", "clig = 0", "liga = 0" }

config.window_close_confirmation = "NeverPrompt"
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.inactive_pane_hsb = {
	saturation = 1.0,
	brightness = 1.0,
}

config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_tab_index_in_tab_bar = false
config.show_new_tab_button_in_tab_bar = false
config.tab_max_width = 32

config.window_background_opacity = 0.9

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
---@param s string
---@return string
local function basename(s)
	local name, _ = string.gsub(s, "(.*[/\\])(.*)", "%2")
	return name
end

wezterm.on("format-tab-title", function(tab)
	local pane = tab.active_pane
	---@diagnostic disable-next-line: undefined-field
	local title = basename(pane.foreground_process_name)
	return {
		{ Text = " " .. title .. " " },
	}
end)

config.leader = { key = "a", mods = "ALT" }
config.keys = {
	-- Pane
	{
		key = "v",
		mods = "LEADER",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "s",
		mods = "LEADER",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "q",
		mods = "LEADER",
		action = action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = action.ActivatePaneDirection("Down"),
	},
	{
		key = "h",
		mods = "LEADER|SHIFT|ALT",
		action = action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "l",
		mods = "LEADER|SHIFT|ALT",
		action = action.AdjustPaneSize({ "Right", 5 }),
	},
	{
		key = "k",
		mods = "LEADER|SHIFT|ALT",
		action = action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "j",
		mods = "LEADER|SHIFT|ALT",
		action = action.AdjustPaneSize({ "Down", 5 }),
	},
	{
		key = "r",
		mods = "LEADER",
		action = action.RotatePanes("Clockwise"),
	},
	{
		key = "R",
		mods = "LEADER",
		action = action.RotatePanes("CounterClockwise"),
	},

	-- Tabs
	{
		key = "w",
		mods = "LEADER",
		action = action.SpawnTab("CurrentPaneDomain"),
	},
	{
		key = "Q",
		mods = "LEADER",
		action = action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "p",
		mods = "LEADER",
		action = action.ActivateTabRelative(-1),
	},
	{
		key = "n",
		mods = "LEADER",
		action = action.ActivateTabRelative(1),
	},
	{
		key = "P",
		mods = "LEADER",
		action = action.MoveTabRelative(-1),
	},
	{
		key = "N",
		mods = "LEADER",
		action = action.MoveTabRelative(1),
	},

	-- Workspaces
	{
		key = "w",
		mods = "LEADER|ALT",
		action = workspace.switch(),
	},
	{
		key = "q",
		mods = "LEADER|ALT",
		action = workspace.close(),
	},
	{
		key = "f",
		mods = "LEADER|ALT",
		action = workspace.switch_to_previous(),
	},
	{
		key = "h",
		mods = "LEADER|ALT",
		action = workspace.switch_to_home(),
	},

	-- Search overlay
	{
		key = "c",
		mods = "LEADER|SHIFT",
		action = action.Search("CurrentSelectionOrEmptyString"),
	},

	-- Copy Mode
	{
		key = "c",
		mods = "LEADER",
		action = action.ActivateCopyMode,
	},
}

for index = 1, 8 do
	table.insert(config.keys, {
		key = tostring(index),
		mods = "LEADER",
		action = action.ActivateTab(index - 1),
	})
end

local copy_mode = wezterm.gui.default_key_tables().copy_mode
table.insert(copy_mode, {
	key = "u",
	action = action.CopyMode("PageUp"),
})
table.insert(copy_mode, {
	key = "d",
	action = action.CopyMode("PageDown"),
})
config.key_tables = {
	copy_mode = copy_mode,
}

return config
