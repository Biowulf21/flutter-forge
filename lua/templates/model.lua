local utils = require("featureForge.utils")

local M = {}
local model_directory = "data/model/"

M.populate_model_template = function(feature_name)
	return M.model_template:gsub("{{ feature_name }}", feature_name)
end

M.create_model = function(feature_name, path)
	local snake_case_feature_name = utils.convert_to_snake_case(feature_name)

	local templates = M.populate_model_template(feature_name)

	local file = snake_case_feature_name .. "_model.dart"

	local file_path = path .. model_directory .. file

	utils.write_to_file(file_path, templates)
end

M.model_template = [[
import 'package:equatable/equatable.dart';

class {{ feature_name }}Model extends Equatable {
	const {{ feature_name }}();

	@override
	List<Object> get props => [];
}
]]

return M
