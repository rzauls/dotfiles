-- Color theme
return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- load during startup since this is main colorscheme
		priority = 1000, -- load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("kanagawa-dragon")
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
