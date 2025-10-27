local M = {}

-- Check if the current OS is Windows
M.is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1

-- Check if the current OS is Mac
M.is_mac = vim.fn.has("mac") == 1

-- Check if format-on-save should be enabled based on NVIM_FORMAT_ON_SAVE env variable
-- Returns true by default, false if env var is set to "0", "false", or "no" (case-insensitive)
M.should_format_on_save = function()
	local env_value = vim.env.NVIM_FORMAT_ON_SAVE
	if env_value == nil then
		return true -- Default to enabled
	end
	local lower_value = string.lower(env_value)
	return not (lower_value == "0" or lower_value == "false" or lower_value == "no")
end

return M
