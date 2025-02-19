-- Color theme
vim.opt.termguicolors = true
return {
	-- "rebelot/kanagawa.nvim",
	-- "savq/melange-nvim",
	"nvim-tree/nvim-web-devicons",
	"marko-cerovac/material.nvim",
	-- {
	-- 	"folke/tokyonight.nvim",
	-- 	dependencies = {
	-- 		"nvim-lualine/lualine.nvim",
	-- 	},
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("lualine").setup({
	-- 			options = {
	-- 				theme = "default",
	-- 			},
	-- 			sections = {
	-- 				lualine_a = { "mode" },
	-- 				lualine_b = { "branch", "diff", "diagnostics" },
	-- 				lualine_c = {
	-- 					{
	-- 						"filename",
	-- 						path = 1,
	-- 					},
	-- 				},
	-- 				lualine_x = { "encoding" },
	-- 				lualine_y = { "filetype" },
	-- 				lualine_z = { "location" },
	-- 			},
	-- 			inactive_sections = {
	-- 				lualine_a = {},
	-- 				lualine_b = {},
	-- 				lualine_c = { "filename" },
	-- 				lualine_x = { "location", "fileformat" },
	-- 				lualine_y = { "progress" },
	-- 				lualine_z = {},
	-- 			},
	-- 		})
	-- 	end,
	-- },
}
