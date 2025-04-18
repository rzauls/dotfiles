return {
	"stevearc/oil.nvim",
	event = "VeryLazy",
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {},
	config = function()
		require("oil").setup({
			view_options = {
				show_hidden = true,
			},
		})
		vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "[O]il up the parent directory" })
		vim.keymap.set("n", "<c-e>", "<CMD>Oil<CR>", { desc = "[O]il up the parent directory" })
	end,
	dependencies = { "nvim-tree/nvim-web-devicons" },
}
