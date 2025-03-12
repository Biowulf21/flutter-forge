local M = {}

M.view_template = [[
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:{{ project_name }}/{{ feature_path }}/data/cubit/{{ feature_name_lowercase }}_cubit.dart';
import 'package:{{ project_name }}/{{ feature_path }}/data/repository/{{ feature_name_lowercase }}_repository.dart';

@RoutePage()
class {{ feature_name }}Page extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return RepositoryProvider(
			create: (context) => Abstract{{ feature_name }}Repository(),
			child: BlocProvider(
				create: (context) => {{ feature_name }}Bloc(
					repository: context.read<{{ feature_name }}Repository>(),
				),
				child: Scaffold(
					appBar: AppBar(
						title: Text('{{ feature_name }}'),
					),
					body: SafeArea(
						child: {{feature_name}}View(),
					),
				),
			),
		);
	}
}

class {{ feature_name }}View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<{{ feature_name }}Bloc, {{ feature_name }}State>(
      builder: (context, state) {
        return Placeholder();
      },
    );
  }
}
]]

return M
