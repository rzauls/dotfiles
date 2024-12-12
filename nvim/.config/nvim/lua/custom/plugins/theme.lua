-- Color theme
vim.opt.termguicolors = true
return {
	"rebelot/kanagawa.nvim",
	"savq/melange-nvim",
	{
		"folke/tokyonight.nvim",
		dependencies = {
			"nvim-lualine/lualine.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		priority = 1000,
		config = function()
			require("lualine").setup({
				options = {
					theme = "tokyonight",
				},
			})
		end,
	},
}
