local utils = require("featureForge.utils")
local M = {}

M.populate_model_template = function(feature_name)
	return M.model_template:gsub("{{ feature_name }}", feature_name)
end

M.create_model = function(feature_name, path)
	local snake_case_feature_name = utils.convert_to_snake_case(feature_name)

	local templates = {
		model_template = M.populate_model_template(feature_name),
	}

	local files = {
		snake_case_feature_name .. "_model.dart",
	}

	for i, file in ipairs(files) do
		local file_path = path .. file
		local file_template = templates[i]

		utils.write_to_file(file_path, file_template)
	end
end

M.model_template = [[
import 'package:equatable/equatable.dart';

class {{ feature_name }} extends Equatable {
	const {{ feature_name }}();

	@override
	List<Object> get props => [];
}
]]

return M
