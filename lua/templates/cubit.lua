local utils = require("featureForge.utils")

local M = {}
local cubit_directory = "data/cubit/"

M.populate_cubit_template = function(feature_name, package_name)
	local feature_name_lowercase = utils.convert_to_lower_case(feature_name)
	return M.cubit_template
		:gsub("{{ feature_name_lowercase }}", feature_name_lowercase)
		:gsub("{{ feature_name }}", feature_name)
		:gsub("{{ project_name }}", package_name)
end

M.populate_cubit_state_template = function(feature_name)
	local feature_name_lowercase = utils.convert_to_lower_case(feature_name)
	return M.cubit_state
		:gsub("{{ feature_name }}", feature_name)
		:gsub("{{ feature_name_lowercase }}", feature_name_lowercase)
end

M.create_cubit = function(feature_name, path)
	local snake_case_feature_name = utils.convert_to_snake_case(feature_name)

	local package_name = utils.get_package_name()
	local templates = {
		cubit_template = M.populate_cubit_template(feature_name, package_name),
		cubit_state = M.populate_cubit_state_template(feature_name),
	}

	local files = {
		snake_case_feature_name .. "_cubit.dart",
		snake_case_feature_name .. "_state.dart",
	}

	-- Map template names to their content for correct lookup
	local template_contents = {
		[files[1]] = templates.cubit_template,
		[files[2]] = templates.cubit_state,
	}

	for _, file in ipairs(files) do
		local file_path = path .. cubit_directory .. file
		local file_content = template_contents[file]

		utils.write_to_file(file_path, file_content)
	end
end

M.cubit_template = [[
import 'package:bloc/bloc.dart';
import 'package:{{ project_name }}/features/{{ feature_name_lowercase }}/data/repository/{{ feature_name_lowercase }}_repository.dart';
import 'package:equatable/equatable.dart';

part '{{ feature_name_lowercase }}_state.dart';

class {{ feature_name }}Cubit extends Cubit<{{ feature_name }}State> {
  {{ feature_name }}Cubit({
    required this.repository,
  }) : super({{ feature_name }}Initial());

  final Abstract{{ feature_name }}Repository repository;

  void fetch{{ feature_name }}() {
    /// Add your logic here
  }

}
]]

M.cubit_state = [[
part of '{{ feature_name_lowercase }}_cubit.dart';

class {{ feature_name }}State extends Equatable {
  const {{ feature_name }}State();

  @override
  List<Object> get props => [];

  {{ feature_name }}State copyWith() {
    return {{ feature_name }}State();
  }
}

class {{ feature_name }}Initial extends {{ feature_name }}State {
  const {{ feature_name }}Initial();
}
]]

return M
