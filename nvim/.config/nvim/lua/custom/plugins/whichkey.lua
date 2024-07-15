-- Display pending keybind help
return {
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup({
			notify = false,
		})

		-- Document existing key chains
		require("which-key").register({
			["<leader>c"] = { name = "[c]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[d]ocument", _ = "which_key_ignore" },
			["<leader>r"] = { name = "[r]ename", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[s]earch", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[w]orkspace", _ = "which_key_ignore" },
		})
	end,
}
