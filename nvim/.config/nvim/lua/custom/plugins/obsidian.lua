if vim.loop.os_uname().sysname == "Darwin" then
	-- local vaultPath = vim.fn.expand("~") .. "/projects/notes/LMT"
	return {
		"epwalsh/obsidian.nvim",
		version = "*",
		ft = "markdown",
		event = { "BufEnter" },
		-- event = {
		-- 	"BufReadPre " .. vaultPath .. "/**.md",
		-- 	"BufNewFile " .. vaultPath .. "/**.md",
		-- },

		dependencies = {
			"nvim-lua/plenary.nvim",
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
