local utils = require("featureForge.utils")

local M = {}

M.populate_repository_template = function(feature_name)
	return M.repository_template:gsub("{{feature_name}}", feature_name)
end

M.create_repository = function(feature_name, path)
	local snake_case_feature_name = utils.convert_to_snake_case(feature_name)

	local templates = {
		repository_template = M.populate_repository_template(feature_name),
	}

	local files = {
		snake_case_feature_name .. "_repository.dart",
	}

	for i, file in ipairs(files) do
		local file_path = path .. file
		local file_template = templates[i]

		utils.write_to_file(file_path, file_template)
	end
end

M.repository_template = [[
abstract class Abstract{{feature_name}}Repository {
	Future<void> fetch{{feature_name}}();
}

class {{feature_name}}Repository implements Abstract{{feature_name}}Repository {
	@override
	Future<void> fetch{{feature_name}}() async {
		/// Add your logic here
	}
}
]]

return M
