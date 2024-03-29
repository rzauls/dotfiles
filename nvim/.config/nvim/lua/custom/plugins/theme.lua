-- Color theme
return {
	{
		"catppuccin/nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		opts = {
			flavour = "mocha",
		},
		config = function()
			vim.cmd.colorscheme("catppuccin")
			-- Configure highlights
			vim.cmd.hi("Comment gui=none")
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
	},
}
