local M = {}

function M.convert_to_snake_case(input)
	return input:gsub("%u", "_%1"):lower()
end

function M.convert_to_lower_case(input)
	return input:lower()
end

-- Check if the current project is a flutter project by recursively
-- checking if the current directory has a pubspec.yaml file
local function get_root_directory()
	local current_buff_directory = vim.fn.expand("%:p:h")

	local max_depth = 5
	local count = 0

	while current_buff_directory ~= "/" and count <= max_depth do
		local pubspec = current_buff_directory .. "/pubspec.yaml"
		if vim.fn.filereadable(pubspec) == 1 then
			return current_buff_directory
		end

		current_buff_directory = vim.fn.fnamemodify(current_buff_directory, ":h")
		count = count + 1
	end

	return nil
end

local function find_value_in_yaml_file(path, key)
	local file = io.open(path, "r")
	if file == nil then
		return nil
	end

	local content = file:read("*a")
	file:close()

	-- Simple YAML parser for key-value pairs at the root level
	local yaml_data = {}
	for line in content:gmatch("[^\r\n]+") do
		-- Skip comments and empty lines
		if not line:match("^%s*#") and line:match("%S") then
			local k, v = line:match("^%s*(%S+)%s*:%s*(.+)%s*$")
			if k and v then
				-- Remove quotes from value if present
				v = v:gsub('^"(.-)"$', "%1"):gsub("^'(.-)'$", "%1")
				yaml_data[k] = v
			end
		end
	end

	return yaml_data[key]
end

function M.check_if_flutter_project()
	local root_directory = get_root_directory()

	if root_directory == nil then
		return false
	end

	return true
end

function M.get_package_name()
	local root_directory = get_root_directory()
	if root_directory == nil then
		error("No Package Found. Aborting...")
		return nil
	end

	return find_value_in_yaml_file(root_directory .. "/pubspec.yaml", "name")
end

function M.write_to_file(path, content)
	local feature_file = io.open(path, "w")
	if feature_file == nil then
		error("Could not create file")
	end
	feature_file:write(content)
	feature_file:close()
end

return M
