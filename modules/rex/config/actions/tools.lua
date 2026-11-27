local utils = require("utils")

local shell = "com.superlogical.terminal.shell"
local tools_category = "Tools"

local function program(ctx, command, label)
	local cwd = utils.terminal_cwd(ctx.block_id)
	return {
		block = {
			flavor = shell,
			label = label,
			options = { command = utils.devshell(cwd, command), cwd = cwd },
		},
	}
end

local function find_float(window_id, label)
	local view, err = rex.session.view({})
	if view == nil then
		error(err, 0)
	end
	for _, window in ipairs(view.windows or {}) do
		if window.window_id == window_id then
			for _, layer in ipairs(window.layers or {}) do
				if layer.kind == "floating" then
					for _, block in ipairs(layer.blocks or {}) do
						if block.label == label then
							return layer
						end
					end
				end
			end
		end
	end
	return nil
end

local function create_or_toggle_float(ctx, label, command)
	local window_id
	if ctx.block_id ~= nil then
		local described = rex.session.describe_block({ block_id = ctx.block_id })
		window_id = described and described.block.window_id
	end

	local layer = window_id and find_float(window_id, label)
	if layer ~= nil then
		local focused = false
		for _, block in ipairs(layer.blocks or {}) do
			focused = focused or block.block_id == ctx.block_id
		end
		local change = { layer_id = layer.layer_id, state = "normal", focus = true }
		if focused and layer.state ~= "minimized" then
			change = { layer_id = layer.layer_id, state = "minimized" }
		end
		local _, err = rex.session.set_layer_state(change)
		if err ~= nil then
			error(err, 0)
		end
		return
	end

	local _, err = rex.session.new_layer({
		window_id = window_id,
		bounds = { 0.08, 0.08, 0.84, 0.84 },
		layout = program(ctx, command, label),
		focus = true,
	})
	if err ~= nil then
		error(err, 0)
	end
end

utils.action({
	name = "yazi",
	keys = { "cmd+e" },
	title = "Open yazi in a Floating Pane",
	category = tools_category,
	run = function(ctx)
		create_or_toggle_float(ctx, "yazi", { "yazi" })
	end,
})

utils.action({
	name = "lazygit",
	keys = { "cmd+g" },
	title = "Open lazygit in a Floating Pane",
	category = tools_category,
	run = function(ctx)
		create_or_toggle_float(ctx, "lazygit", { "lazygit" })
	end,
})

utils.action({
	name = "claude",
	keys = { "cmd+l", { "cmd+shift+l", { resume = true } } },
	title = "Open Claude Code in a Split",
	category = tools_category,
	args = { resume = "boolean?" },
	run = function(ctx, args)
		local command = { "claude" }
		if args.resume then
			table.insert(command, "--resume")
		end
		local _, err = rex.session.new_split({
			anchor_id = ctx.block_id,
			direction = "horizontal",
			side = "after",
			ratio = 0.6,
			layout = program(ctx, command),
			focus = true,
		})
		if err ~= nil then
			error(err, 0)
		end
	end,
})
