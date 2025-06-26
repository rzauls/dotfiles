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
		end,
	},
	"lewis6991/gitsigns.nvim", -- Add git related signs to the gutter, as well as utilities for managing changes
}
