return {
	{ -- Run commands with a popup output
		"rzauls/executor.nvim",
		dependencies = {
			-- TODO: get rid of this dependency and use something that I already have
			"MunifTanjim/nui.nvim",
		},
		config = function()
			local executor = require("executor")

			executor.setup({
				use_split = false,
				popup = {
					width = math.floor(vim.o.columns * 3 / 5),
					height = vim.o.lines - 20,
					border = {
						padding = {
							top = 1,
							bottom = 1,
							left = 2,
							right = 2,
						},
						style = "rounded",
					},
				},
				notifications = {
					show_after_done = true,
				},
				preset_commands = {
					["projects"] = {
						"make test",
						{ partial = true, cmd = "go test ./... --run=" },
					},
				},
			})

			vim.keymap.set("n", "<leader>er", function()
				executor.commands.run()
			end)

			vim.keymap.set("n", "<leader>es", function()
				executor.commands.set_command()
			end)

			vim.keymap.set("n", "<leader>ev", function()
				executor.commands.toggle_detail()
			end)

			vim.keymap.set("n", "<leader>ep", function()
				executor.commands.show_presets()
			end)

			vim.keymap.set("n", "<Esc>", function()
				executor.commands.hide_detail()
			end)
		end,
	},
}
