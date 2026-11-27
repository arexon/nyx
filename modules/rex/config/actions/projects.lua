local utils = require("utils")

local terminal = "com.superlogical.terminal"
local shell = "com.superlogical.terminal.shell"
local projects_dir = os.getenv("HOME") .. "/Projects"
local user_path = "/etc/profiles/per-user/" .. os.getenv("USER") .. "/bin:" .. os.getenv("PATH")

local function list_projects()
	local result = rex.exec({
		"fd", "--hidden", "--type", "d", "--type", "f", "--max-depth", "5", "--prune", "^\\.git$", projects_dir,
	}, { env = { PATH = user_path } })
	if result == nil or not result.ok then
		error("couldn't list " .. projects_dir, 0)
	end
	local names = {}
	for path in result.stdout:gmatch("[^\n]+") do
		table.insert(names, path:gsub("/%.git/?$", ""):sub(#projects_dir + 2))
	end
	table.sort(names)
	return names
end

local function open_sessions()
	local result, err = rex.call("session.list")
	if result == nil then
		error(err, 0)
	end
	local by_label = {}
	for _, session in ipairs(result.sessions or {}) do
		by_label[session.label] = session.session_id
	end
	return by_label
end

local function is_project(name)
	for _, project in ipairs(list_projects()) do
		if project == name then
			return true
		end
	end
	return false
end

local function terminal_block(dir, command, label)
	return {
		block = {
			flavor = shell,
			label = label,
			options = { command = utils.devshell(dir, command), cwd = dir },
		},
	}
end

local function show(session_id, window_id)
	pcall(rex.client.queue, "session.select", { session_id = session_id, window_id = window_id })
end

local function open_project(name)
	if not is_project(name) then
		error("no git repository named " .. name .. " in " .. projects_dir, 0)
	end

	local existing = open_sessions()[name]
	if existing ~= nil then
		show(existing)
		return { session_id = existing, created = false }
	end

	local dir = projects_dir .. "/" .. name
	local session, err = rex.call("session.create", {
		label = name,
		initial_windows = { { window_label = "Shell", layout = terminal_block(dir, nil, "shell") } },
	})
	if session == nil then
		error(err, 0)
	end

	local window_id = session.initial_windows[1].window_id
	local _, focus_err = rex.call("session.attach", { session_id = session.session_id })
	if focus_err == nil then
		_, focus_err = rex.call("session.focus_window", { session_id = session.session_id, window_id = window_id })
	end
	if focus_err ~= nil then
		rex.log("warn", "open_project: couldn't focus " .. name .. ": " .. focus_err)
	end
	show(session.session_id, window_id)
	return { session_id = session.session_id, created = true }
end

utils.action({
	name = "open_project",
	keys = { "cmd+o" },
	title = "Open Project…",
	category = "Projects",
	keywords = "project open workspace folder",
	args = { project = "string?" },
	run = function(ctx, args)
		local name = args.project
		if name == nil then
			if rex.ui == nil then
				error("the project picker needs Rex 0.1.0-preview.21 or later; update Rex.app and restart its server", 0)
			end
			local open = open_sessions()
			local items = {}
			for _, project in ipairs(list_projects()) do
				table.insert(items, {
					id = project,
					title = project:match("[^/]+$"),
					subtitle = project:match("^(.+)/[^/]+$"),
					icon = "branch",
					detail = open[project] ~= nil and "open" or nil,
				})
			end
			local choice, why = rex.ui.pick({
				title = "Open project",
				placeholder = "Filter projects",
				items = items,
			})
			if choice == nil then
				if why ~= "cancelled" then
					rex.log("warn", "open_project: " .. why)
				end
				return
			end
			name = choice
		end
		return open_project(name)
	end,
})

-- Finds the program running in block_id from its process. Arguments aren't
-- available, so the program restarts without them. A pane whose program runs
-- under an interactive shell restarts as a shell.
local function process_command(block_id)
	local process = rex.block.call(terminal, "process", { block_id = block_id })
	local child = process and process.child
	if child == nil or child.argv0 == nil or child.name == "login" then
		return utils.terminal_cwd(block_id), nil
	end
	return child.cwd or utils.terminal_cwd(block_id), { child.argv0 }
end

-- Restarts the focused pane in place so that its program picks up changes to
-- the devshell.
local function reload_pane(ctx)
	local block_id = ctx.block_id
	if block_id == nil then
		error("no pane to reload", 0)
	end
	local described, err = rex.session.describe_block({ block_id = block_id })
	if described == nil then
		error(err, 0)
	end
	local block = described.block
	local dir, command = process_command(block_id)

	-- Rex can't restart a block's program, so open the new pane beside the
	-- old one and close the old one. The split then collapses, and the new
	-- pane takes the old pane's place.
	local created, close_err
	created, err = rex.session.new_split({
		anchor_id = block_id,
		direction = "horizontal",
		side = "after",
		ratio = 0.5,
		layout = terminal_block(dir, command, block.label),
		focus = true,
	})
	if created == nil then
		error(err, 0)
	end
	_, close_err = rex.call("block.close", { session_id = ctx.session_id, block_id = block_id })
	if close_err ~= nil then
		error(close_err, 0)
	end
end

utils.action({
	name = "reload_pane",
	keys = { "cmd+shift+r" },
	title = "Reload Pane",
	category = "Pane",
	keywords = "restart respawn devshell direnv",
	run = reload_pane,
})
