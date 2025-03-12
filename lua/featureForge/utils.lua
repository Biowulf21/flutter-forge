local M = {}

function M.convert_to_snake_case(input)
	return input:gsub("%u", "_%1"):lower()
end

return M
