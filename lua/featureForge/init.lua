local utils = require("featureForge.utils")
local M = {}

function M.createFeature()
	local feature_name = vim.fn.input("Enter feature name: ")

	if feature_name == "" then
		error("Feature name cannot be empty")
		return
	end

	local current_buff_directory = vim.fn.expand("%:p:h")
	local feature_directory = current_buff_directory .. "/features/" .. feature_name
	if feature_directory == "" then
		error("Feature directory cannot be empty")
		return
	end

	local feature_lowercase_name = utils.convert_to_snake_case(feature_name)
end

return M
