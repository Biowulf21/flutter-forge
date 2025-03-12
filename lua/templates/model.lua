local M = {}

M.model_template = [[
import 'package:equatable/equatable.dart';

class {{ feature_name }} extends Equatable {
	const {{ feature_name }}();

	@override
	List<Object> get props => [];
}
]]

return M
