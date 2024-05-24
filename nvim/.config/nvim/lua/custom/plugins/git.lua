return {
	{ -- Magit clone for neovim
		"NeogitOrg/neogit",
		branch = "master",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"sindrets/diffview.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local neogit = require("neogit")
			neogit.setup({})
			vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Neo[g]it: open [g]it UI" })
			vim.keymap.set("n", "<leader>gp", neogit.action("pull", "from_upstream"), { desc = "Neo[g]it: [p]ull upstream" })
			vim.keymap.set("n", "<leader>gP", neogit.action("push", "to_upstream"), { desc = "Neo[g]it: [P]ush upstream" })
		end,
	},
	{ -- Add git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		opts = {
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
				untracked = { text = "┆" },
			},
		},
	},
}
