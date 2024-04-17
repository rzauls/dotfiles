-- Golang specific configuration
vim.filetype.add({ extension = { templ = "templ" } })

return {
	{
		-- dir = "/home/rihards/projects/checkmark.nvim/",
		"rzauls/checkmark.nvim",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			local checkmark = require("checkmark")
			checkmark.setup({})
			vim.keymap.set("n", "<leader>ct", checkmark.run_tests, { desc = "Checkmark: Run tests of current file" })
		end,
	},
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
				trouble = true, -- use trouble.nvim to open quickfix
			})

			vim.keymap.set("n", "<leader>gt", function()
				local trouble = require("trouble")

				trouble.close() -- close existing window (it gets reopened if tests fail)
				require("go.gotest").test()
				trouble.refresh() -- refresh trouble window
			end, { desc = "[g]o: Run go [t]ests" })
		end,
		event = { "CmdlineEnter" },
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
}
