local M = {}

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
