local M = {}

local terminal = "com.superlogical.terminal"

-- Returns the nearest directory at or above dir that contains name.
local function find_up(dir, name)
	while dir ~= nil and dir ~= "" do
		local file = io.open(dir .. "/" .. name, "r")
		if file ~= nil then
			file:close()
			return dir
		end
		if dir == "/" then
			return nil
		end
		dir = dir:match("^(.*)/[^/]*$")
		if dir == "" then
			dir = "/"
		end
	end
	return nil
end

local function concat(prefix, command)
	local result = {}
	for _, word in ipairs(prefix) do
		table.insert(result, word)
	end
	for _, word in ipairs(command) do
		table.insert(result, word)
	end
	return result
end

-- Registers spec as an action with rex.action. spec.keys lists the keys that
-- run it: each entry is a key, or a { key, args } pair that passes args to the
-- action.
function M.action(spec)
	local action = {}
	for field, value in pairs(spec) do
		if field ~= "keys" then
			action[field] = value
		end
	end
	rex.action(action)
	for _, key in ipairs(spec.keys or {}) do
		if type(key) == "string" then
			rex.bind(key, spec.name)
		else
			rex.bind(key[1], spec.name, key[2])
		end
	end
end

-- Returns the working directory that the terminal in block_id last reported.
function M.terminal_cwd(block_id)
	if block_id == nil then
		return nil
	end
	local result = rex.block.call(terminal, "pwd", { block_id = block_id })
	if result == nil or result.pwd == nil then
		return nil
	end
	local path = result.pwd:gsub("^file://[^/]*", "")
	path = path:gsub("%%(%x%x)", function(hex)
		return string.char(tonumber(hex, 16))
	end)
	return path
end

-- Wraps command so that it runs through `direnv exec` when an .envrc exists at
-- or above dir. A nil command means an interactive shell, which needs no
-- wrapper, because the shell's direnv hook loads .envrc.
function M.devshell(dir, command)
	if dir == nil or command == nil or find_up(dir, ".envrc") == nil then
		return command
	end
	return concat({ "direnv", "exec", dir }, command)
end

return M
