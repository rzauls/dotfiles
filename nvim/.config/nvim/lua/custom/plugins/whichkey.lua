-- Display pending keybind help
return {
	"folke/which-key.nvim",
	event = "VeryLazy", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup({
			notify = false,
		})

		-- Document existing key chains
		require("which-key").add({
			{ "<leader>c", group = "[c]ode" },
			{ "<leader>d", group = "[d]ocument" },
			{ "<leader>r", group = "[r]ename" },
			{ "<leader>s", group = "[s]earch" },
			{ "<leader>w", group = "[w]orkspace" },
		})
	end,
}
