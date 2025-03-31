local note_file = os.getenv("TODO_NOTE_FILE")
if note_file == nil then
	note_file = "~/notes.md"
end

vim.keymap.set("n", "<leader>oo", function()
	return vim.cmd("e " .. note_file)
end, { desc = "[o]pen [o] notes.md file" })

if vim.loop.os_uname().sysname == "Darwin" then
	-- local vaultPath = vim.fn.expand("~") .. "/projects/notes/LMT"
	--
	vim.keymap.set("n", "<leader>so", function()
		return vim.cmd("ObsidianQuickSwitch")
	end, { desc = "[s]earch [o]bsidian files" })

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
