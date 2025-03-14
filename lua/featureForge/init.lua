local utils = require("featureForge.utils")
local cubit = require("templates.cubit")
local model = require("templates.model")
local repository = require("templates.repository")
local view = require("templates.view")
local M = {}

-- Helper function to validate Flutter project and get component information
local function validateFlutterProject()
	local is_flutter_project = utils.check_if_flutter_project()
	if not is_flutter_project then
		error("Cannot run FeatureForge outside of a Flutter project!")
		return false
	end
	return true
end

-- Helper function to get user input for component name
local function getComponentName(component_type)
	local name = vim.fn.input("Enter " .. component_type .. " name: ")
	if name == "" then
		error(component_type .. " name cannot be empty")
		return nil
	end
	return name
end

-- Helper function to get path for component
local function getComponentPath(component_type, default_subpath)
	local current_buff_path = utils.get_current_buffer_path()
	return vim.fn.input(component_type .. " path: ", current_buff_path .. default_subpath)
end

-- Helper function to complete component creation
local function finishCreation(message, file_path)
	print(message)
	if file_path then
		vim.cmd("e " .. file_path)
	end
	utils.run_dart_fix()
end

function M.createFeature()
	if not validateFlutterProject() then
		return
	end

	local feature_name = getComponentName("feature")
	if not feature_name then
		return
	end

	local feature_path = getComponentPath("Feature", "feature/")

	-- Create all components for the feature
	cubit.create_cubit(feature_name, feature_path)
	model.create_model(feature_name, feature_path)
	repository.create_repository(feature_name, feature_path)
	local view_path = view.create_view(feature_name, feature_path)

	finishCreation("Feature created successfully!", view_path)
end

M.createView = function()
	if not validateFlutterProject() then
		return
	end

	local view_name = getComponentName("view")
	if not view_name then
		return
	end

	local view_path = getComponentPath("View", "presentation/view/")
	local created_path = view.create_view(view_name, view_path)

	finishCreation("View created successfully!", created_path)
end

M.createRepository = function()
	if not validateFlutterProject() then
		return
	end

	local repo_name = getComponentName("repository")
	if not repo_name then
		return
	end

	local repo_path = getComponentPath("Repository", "data/repository/")
	repository.create_repository(repo_name, repo_path)

	finishCreation("Repository created successfully!")
end

M.createModel = function()
	if not validateFlutterProject() then
		return
	end

	local model_name = getComponentName("model")
	if not model_name then
		return
	end

	local model_path = getComponentPath("Model", "data/models/")
	model.create_model(model_name, model_path)

	finishCreation("Model created successfully!")
end

M.createCubit = function()
	if not validateFlutterProject() then
		return
	end

	local cubit_name = getComponentName("cubit")
	if not cubit_name then
		return
	end

	local cubit_path = getComponentPath("Cubit", "presentation/cubit/")
	cubit.create_cubit(cubit_name, cubit_path)

	finishCreation("Cubit created successfully!")
end

return M
