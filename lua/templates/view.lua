local utils = require("featureForge.utils")

local M = {}
local view_directory = "view/"

M.populate_view_template = function(project_name, feature_name, feature_path)
	local feature_name_lowercase = utils.convert_to_lower_case(feature_name)
	return M.view_template
		:gsub("{{ feature_name }}", feature_name)
		:gsub("{{ project_name }}", project_name)
		:gsub("{{ feature_path }}", feature_path)
		:gsub("{{ feature_name_lowercase }}", feature_name_lowercase)
end

M.create_view = function(feature_name, path)
	local snake_case_feature_name = utils.convert_to_snake_case(feature_name)
	local package_name = utils.get_package_name()

	if package_name == nil then
		error("Could not find package name in pubspec.yaml")
	end

	local template = M.populate_view_template(package_name, feature_name, path)

	local page_file_name = snake_case_feature_name .. "_page.dart"
	utils.write_to_file(path .. view_directory .. page_file_name, template)

	return path .. view_directory .. page_file_name
end

M.view_template = [[
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{ project_name }}/features/{{ feature_name_lowercase }}/data/cubit/{{ feature_name_lowercase }}_cubit.dart';
import 'package:{{ project_name }}/features/{{ feature_name_lowercase }}/data/repository/{{ feature_name_lowercase }}_repository.dart';

@RoutePage()
class {{ feature_name }}Page extends StatelessWidget {
  const {{ feature_name }}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<Abstract{{ feature_name }}Repository>(
      create: (context) => {{ feature_name }}Repository(),
      child: BlocProvider(
        create: (context) => {{ feature_name }}Cubit(
          repository: context.read<Abstract{{ feature_name }}Repository>(),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('{{ feature_name }}'),
          ),
          body: const SafeArea(
            child: {{ feature_name }}View(),
          ),
        ),
      ),
    );
  }
}

class {{ feature_name }}View extends StatelessWidget {
  const {{ feature_name }}View({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<{{ feature_name }}Cubit, {{ feature_name }}State>(
      builder: (context, state) {
        return const Placeholder();
      },
    );
  }
}
]]

return M
