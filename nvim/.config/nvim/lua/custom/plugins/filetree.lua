-- Filetree sidebar
return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
		"MunifTanjim/nui.nvim",
		-- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			filesystem = {
				filtered_items = {
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_by_name = {
						".github",
						".DS_Store",
						".vscode",
						".idea",
						"thumbs.db",
					},
					never_show = { ".git" },
				},
			},
		})

		vim.keymap.set("n", "<leader><C-e>", function()
			require("neo-tree.command").execute({ action = "focus", toggle = true })
		end, { desc = "Toggle Neotree (file [e]xplorer) panel" })
	end,
}
