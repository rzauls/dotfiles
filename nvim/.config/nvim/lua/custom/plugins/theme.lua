-- Color theme
vim.opt.termguicolors = true
vim.cmd.colorscheme("default")
return {
	{
		"rebelot/kanagawa.nvim",
		config = function()
			-- vim.cmd.colorscheme("kanagawa-dragon")
		end,
	},
	{
		"savq/melange-nvim",
		lazy = false, -- load during startup since this is main colorscheme
		priority = 1000, -- load this before all the other start plugins
		config = function()
			-- vim.cmd.colorscheme("melange")
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
}
