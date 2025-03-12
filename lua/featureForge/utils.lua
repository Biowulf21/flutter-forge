local M = {}

function M.convert_to_snake_case(input)
	return input:gsub("%u", "_%1"):lower()
end

function M.convert_to_lower_case(input)
	return input:lower()
end

-- Check if the current project is a flutter project by recursively
-- checking if the current directory has a pubspec.yaml file
function M.check_if_flutter_project()
	local current_buff_directory = vim.fn.expand("%:p:h")

	local max_depth = 5
	local count = 0

	while current_buff_directory ~= "/" and count <= max_depth do
		local pubspec = current_buff_directory .. "/pubspec.yaml"
		if vim.fn.filereadable(pubspec) == 1 then
			return true
		end

		current_buff_directory = vim.fn.fnamemodify(current_buff_directory, ":h")
		count = count + 1
	end

	return false
end

return M
