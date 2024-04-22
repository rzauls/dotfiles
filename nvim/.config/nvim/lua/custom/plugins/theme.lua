-- Color theme
return {
	{
		"rebelot/kanagawa.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd.colorscheme("kanagawa")
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{
		"catppuccin/nvim",
		opts = {
			flavour = "mocha",
		},
		config = function()
			-- vim.cmd.colorscheme("catppuccin")
			-- vim.cmd.hi("Comment gui=none")
		end,
	},
}
