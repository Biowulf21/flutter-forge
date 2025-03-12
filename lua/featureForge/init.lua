local utils = require("featureForge.utils")
local cubit = require("templates.cubit")
local model = require("templates.model")
local repository = require("templates.repository")
local view = require("templates.view")
local M = {}

function M.createFeature()
	local is_flutter_project = utils.check_if_flutter_project()

	if not is_flutter_project then
		error("Cannot run FeatureForge outside of a Flutter project!")
		return
	end

	local feature_name = vim.fn.input("Enter feature name: ")

	if feature_name == "" then
		error("Feature name cannot be empty")
		return
	end

	local feature_folder = utils.get_features_folder()
	if feature_folder == nil then
		error("No features directory found. Aborting...")
		return
	end
	local feature_path = feature_folder .. feature_name .. "/"
	if feature_folder == "" then
		error("Feature directory cannot be empty")
		return
	end

	local feature_name_lowercase = utils.convert_to_snake_case(feature_name)

	cubit.create_cubit(feature_name, feature_path)
	model.create_model(feature_name, feature_path)
	repository.create_repository(feature_name, feature_path)
	local view_path = view.create_view(feature_name, feature_path)

	print("Feature created successfully!")

	-- Open the the created page file
	vim.cmd("e " .. view_path)
end

return M
