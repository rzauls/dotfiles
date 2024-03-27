-- Magit clone for neovim
-- use ? to see default keymaps
return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"sindrets/diffview.nvim",
		"nvim-telescope/telescope.nvim",
	},
	config = function()
		local neogit = require("neogit")
		neogit.setup({})
		vim.keymap.set("n", "<leader>gg", neogit.open, { desc = "Neo[g]it: open" })
		vim.keymap.set("n", "<leader><c-p>", neogit.action("pull", "from_upstream"), { desc = "Neogit: [p]ull changes" })
	end,
}
