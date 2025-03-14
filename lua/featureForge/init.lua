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
	local current_buff_path = utils.get_current_buffer_path()
	local feature_path = vim.fn.input("Feature path: ", current_buff_path .. "feature/")

	-- local feature_folder = utils.get_features_folder()
	-- if feature_folder == nil then
	-- 	error("No features directory found. Aborting...")
	-- 	return
	-- end
	-- local feature_path = feature_folder .. feature_name .. "/"
	-- if feature_folder == "" then
	-- 	error("Feature directory cannot be empty")
	-- 	return
	-- end

	cubit.create_cubit(feature_name, feature_path)
	model.create_model(feature_name, feature_path)
	repository.create_repository(feature_name, feature_path)
	local view_path = view.create_view(feature_name, feature_path)

	print("Feature created successfully!")

	-- Open the created page file
	vim.cmd("e " .. view_path)

	-- Get the project root directory for running dart fix
	local root_dir = utils.get_root_directory()

	-- run dart fix --apply in the project root directory
	print("Running dart fix --apply")

	local job_id = vim.fn.jobstart("cd " .. root_dir .. " && dart fix --apply", {
		on_exit = function(_, exit_code, _)
			if exit_code == 0 then
				print("Dart fix completed successfully")
			else
				print("Dart fix failed with exit code: " .. exit_code)
			end
		end,
	})

	-- Check if job started successfully
	if job_id == 0 then
		print("Error: Invalid arguments for job")
	elseif job_id == -1 then
		print("Error: Command not executable")
	end
end

return M
