---@type Wezterm
---@diagnostic disable-next-line: assign-type-mismatch
local wezterm = require("wezterm")
local act = wezterm.action
local mux = wezterm.mux
---@type { previous_workspace?: string }
---@diagnostic disable-next-line: assign-type-mismatch
local GLOBAL = wezterm.GLOBAL

local PROJECTS_DIR = wezterm.home_dir .. "/projects/"
local WORKSPACE_SWTICHED_EVENT = "workspace.switched"
local FUZZY_DESCRPTION = "::: "

---@alias InputSelectorChoices { id: string, label: string }[]
---@alias Workspace { name: string, label: string }
---@alias Workspaces Workspace[]

---@param args string[]
---@return string
local function run_child_process(args)
	local success, stdout, stderr = wezterm.run_child_process(args)

	if not success then
		wezterm.log_error("Child process '" .. args[1] .. "' failed with stderr: '" .. stderr .. "'")
	end
	return stdout
end

---@param tbl table<any, any>
---@param callback fun(any, any): boolean
---@return table<any, any>
local function filter(tbl, callback)
	local fill_tbl = {}
	for i, v in ipairs(tbl) do
		if callback(v, i) then
			table.insert(fill_tbl, v)
		end
	end
	return fill_tbl
end

---@return string[]
local function get_projects()
	local args = {
		"nu",
		"-c",
		"ls ~/projects/*/.git | append (ls ~/projects/minecraft/**/*/.git) | get name | each {path dirname} | to text",
	}
	return wezterm.split_by_newlines(run_child_process(args))
end

---@return Workspaces
local function get_workspaces()
	---@type Workspaces
	local workspaces = {}
	for _, workspace_name in ipairs(mux.get_workspace_names()) do
		local is_active_workspace = mux.get_active_workspace() == workspace_name

		---@type string
		local label
		if is_active_workspace then
			label = "*" .. workspace_name
		else
			label = workspace_name
		end

		---@type Workspace
		local entry = {
			name = workspace_name,
			label = wezterm.format({
				{ Attribute = { Intensity = "Bold" } },
				{ Attribute = { Italic = true } },
				{ Text = label },
			}),
		}
		if is_active_workspace then
			table.insert(workspaces, 1, entry)
		else
			table.insert(workspaces, entry)
		end
	end
	return workspaces
end

---@param workspace string
---@return boolean
local function workspace_exists(workspace)
	for _, workspace_name in ipairs(mux.get_workspace_names()) do
		if workspace == workspace_name then
			return true
		end
	end
	return false
end

---@param workspace string
local function close_workspace(workspace)
	local stdout = run_child_process({ "wezterm", "cli", "list", "--format=json" })
	local json = wezterm.json_parse(stdout)
	if not json then
		return
	end

	local workspace_panes = filter(json, function(object)
		return object.workspace == workspace
	end)

	for _, object in ipairs(workspace_panes) do
		run_child_process({ "wezterm", "cli", "kill-pane", "--pane-id=" .. object.pane_id })
	end
end

---@return InputSelectorChoices
local function get_choices()
	---@type InputSelectorChoices
	local choices = {}

	local projects = get_projects()
	local workspaces = get_workspaces()

	for _, workspace in ipairs(workspaces) do
		table.insert(choices, {
			label = workspace.label,
			id = workspace.name,
		})
	end

	for _, path in ipairs(projects) do
		local display_path = string.gsub(path, PROJECTS_DIR, "")
		if not workspace_exists(display_path) then
			table.insert(choices, {
				label = display_path,
				id = display_path,
			})
		end
	end

	return choices
end

wezterm.on(WORKSPACE_SWTICHED_EVENT, function(window)
	GLOBAL.previous_workspace = window:active_workspace()
end)

local M = {}

M.HOME_WORKSPACE_NAME = "home"

function M.switch()
	return wezterm.action_callback(function(window, pane)
		local choices = get_choices()
		window:perform_action(
			---@diagnostic disable-next-line: param-type-mismatch
			act.InputSelector({
				title = "Switch workspace",
				description = "Switch workspace",
				choices = choices,
				fuzzy = true,
				fuzzy_description = FUZZY_DESCRPTION,
				action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
					if id and label then
						wezterm.emit(WORKSPACE_SWTICHED_EVENT, window)

						local opts
						if workspace_exists(id) then
							opts = { name = id }
						else
							local cwd
							if id == M.HOME_WORKSPACE_NAME then
								cwd = wezterm.home_dir
							else
								cwd = PROJECTS_DIR .. id
							end
							opts = { name = id, spawn = { cwd = cwd } }
						end

						inner_window:perform_action(
							---@diagnostic disable-next-line: param-type-mismatch
							act.SwitchToWorkspace(opts),
							inner_pane
						)
					end
				end),
			}),
			pane
		)
	end)
end

function M.close()
	return wezterm.action_callback(function(window, pane)
		local choices = get_choices()
		window:perform_action(
			---@diagnostic disable-next-line: param-type-mismatch
			act.InputSelector({
				title = "Close workspace",
				description = "Close workspace",
				choices = choices,
				fuzzy = true,
				fuzzy_description = FUZZY_DESCRPTION,
				action = wezterm.action_callback(function(_, _, id)
					if id then
						close_workspace(id)
					end
				end),
			}),
			pane
		)
	end)
end

function M.switch_to_previous()
	return wezterm.action_callback(function(window, pane)
		local current_workspace = window:active_workspace()
		local previous_workspace = GLOBAL.previous_workspace

		if current_workspace == previous_workspace or previous_workspace == nil then
			return
		end

		GLOBAL.previous_workspace = current_workspace

		window:perform_action(
			---@diagnostic disable-next-line: param-type-mismatch
			act.SwitchToWorkspace({
				name = previous_workspace,
			}),
			pane
		)
	end)
end

function M.switch_to_home()
	return wezterm.action_callback(function(window, pane)
		wezterm.emit(WORKSPACE_SWTICHED_EVENT, window)
		window:perform_action(
			---@diagnostic disable-next-line: param-type-mismatch
			act.SwitchToWorkspace({
				name = M.HOME_WORKSPACE_NAME,
			}),
			pane
		)
	end)
end

return M
