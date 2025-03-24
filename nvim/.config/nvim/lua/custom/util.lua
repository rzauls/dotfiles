local M = {}

-- Check if the current OS is Windows
M.is_windows = vim.fn.has("win64") == 1 or vim.fn.has("win32") == 1 or vim.fn.has("win16") == 1

-- Check if the current OS is Mac
M.is_mac = vim.fn.has("mac") == 1

return M
