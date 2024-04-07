-- Helper functions for lua and lua plugin development

---Print a human-readable representation of v and return it afterwards
P = function(v)
	print(vim.inspect(v))
	return v
end

RELOAD = function(...)
	return require("plenary.reload").reload_module(...)
end

---Re-require a lua module
R = function(name)
	RELOAD(name)
	return require(name)
end

-- Lua testing keymaps
vim.keymap.set("n", "<leader>lt", function()
	require("plenary.test_harness").test_file(vim.api.nvim_buf_get_name(0))
end, { desc = "Plenary: Run current [l]ua [t]est file" })

return {}
