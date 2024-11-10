if vim.loop.os_uname().sysname == "Darwin" then
	return {
		"epwalsh/obsidian.nvim",
		version = "v3.9.0",
		ft = "markdown",
		event = {
			"BufEnter",
		},

		-- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
		-- event = {
		--   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
		--   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/**.md"
		--   "BufReadPre path/to/my-vault/**.md",
		--   "BufNewFile path/to/my-vault/**.md",
		-- },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-telescope/telescope.nvim",
			"nvim-treesitter/nvim-treesitter",
		},
		opts = {
			workspaces = {
				{
					name = "LMT",
					path = "~/projects/notes/LMT",
				},
			},
			daily_notes = {
				date_format = "%d-%m-%Y",
				default_tags = { "dailies" },
				folder = "dailies",
			},
		},
	}
else
	return {}
end
