local M = {}

M.cubit_template = [[
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part '{{ feature_name }}_state.dart';

class {{ feature_name}}Cubit extends Cubit<{{ feature_name }}State> {
  {{ feature_name }}Cubit({
	  required this.repository,
  }) : super({{ feature_name }}Initial());

  final Abstract{{feature_name}}Repository repository;

  void fetch{{ feature_name }}() {
	  /// Add your logic here
    }


]]

M.cubit_state = [[

part of '{{ feature_name }}_cubit.dart';

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
