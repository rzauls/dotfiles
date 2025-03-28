-- Golang specific configuration
vim.filetype.add({ extension = { templ = "templ" } })

return {
	{
		"ray-x/go.nvim",
		event = "CmdlineEnter",
		dependencies = { -- optional packages
			"ray-x/guihua.lua",
		},
		config = function()
			require("go").setup({
				dap_debug = false, -- handle dap setup manually
				trouble = false, -- use trouble.nvim to open quickfix
			})
		end,
		ft = { "go", "gomod" },
		build = ':lua require("go.install").update_all_sync()',
	},
}
