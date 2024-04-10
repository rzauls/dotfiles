-- Golang specific configuration
vim.filetype.add({ extension = { templ = "templ" } })

return {
	{
		"ray-x/go.nvim",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
			"neovim/nvim-lspconfig",
			"nvim-treesitter/nvim-treesitter",
			"folke/trouble.nvim",
		},
		config = function()
			require("go").setup({
				dap_debug = false, -- handle dap setup manually
				trouble = true, -- true: use trouble to open quickfix
			})

			vim.keymap.set("n", "<leader>gt", function()
				require("go.gotest").test()
				require("trouble").refresh() -- refresh trouble window
			end, { desc = "[g]o: Run go [t]ests" })
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
}
